import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:newsapp/app/routes/app_routes.dart';

class FirebaseAuthAPI {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getAllUsers() {
    return db.collection("users").snapshots();
  }

  Future<QuerySnapshot> getUser(userid) async {
    QuerySnapshot data =
        await db.collection('users').where('userId', isEqualTo: userid).get();

    return data;
  }

  Future signIn(String email, String password) async {
    UserCredential credential;
    try {
      final credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e.code);
      return e.code;
    }
  }

  void signOut() async {
    auth.signOut();
    Get.offAll(AppRoutes.welcome);
  }

  Future signUp(String email, String password, String name, String loc,
      String mob) async {
    UserCredential credential;

    try {
      credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        saveUserToFirestore(credential.user?.uid, email, name, loc, mob);
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
      return e.code;
    }
  }

  void saveUserToFirestore(
      String? uid, String email, String name, String loc, String mob) async {
    try {
      await db.collection("users").doc(uid).set({
        "userId": uid,
        "email": email,
        "fname": name,
        "loc": loc,
        "mob": mob
      });
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }
}
