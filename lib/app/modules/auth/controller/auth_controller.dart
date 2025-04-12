import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../api_servises/firebase_auth_api.dart';
import '../../../model/user_model.dart';
import '../../../routes/app_routes.dart';

class AuthController extends GetxController {
  var currentPage = 0.obs;
  final FirebaseAuthAPI authService = FirebaseAuthAPI();

  late final Stream<QuerySnapshot> _usersStream;
  Stream<QuerySnapshot> get users => _usersStream;

  Rxn<User> userObj = Rxn<User>();
  RxBool isLoading = true.obs;

  User? get user => userObj.value;
  String? get userId => userObj.value?.userId;
  bool get isAuthenticated => userObj.value != null;
  RxBool isLoggingIn = false.obs;

  void changePage(int index) {
    currentPage.value = index;
  }

  void nextPage(int totalPages, PageController pageController) {
    if (currentPage.value < totalPages - 1) {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  void navigateToLogin() {
    Get.toNamed(AppRoutes.signin);
  }

  @override
  void onInit() {
    super.onInit();
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    final firebaseUser = fb_auth.FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      final data = await authService.getUser(firebaseUser.uid);
      if (data.docs.isNotEmpty) {
        userObj.value =
            User.fromMap(data.docs.first.data() as Map<String, dynamic>);
      }
    }
    isLoading.value = false;
  }

  Future<void> signUp(String name, String email, String mobileNo, String loc,
      String pass, String conPass) async {
    // Validation
    if ([name, email, mobileNo, loc, pass, conPass]
        .any((field) => field.isEmpty)) {
      Get.snackbar("Error", "All fields are required");
      return;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar("Invalid Email", "Please enter a valid email address");
      return;
    }

    if (!RegExp(r'^\d{10}$').hasMatch(mobileNo)) {
      Get.snackbar(
          "Invalid Mobile Number", "Enter a valid 10-digit mobile number");
      return;
    }

    if (pass.length < 6) {
      Get.snackbar(
          "Weak Password", "Password must be at least 6 characters long");
      return;
    }

    if (pass != conPass) {
      Get.snackbar(
          "Password Mismatch", "Password and confirm password do not match");
      return;
    }

    final result = await authService.signUp(email, pass, name, loc, mobileNo);

    if (result == null) {
      Get.snackbar("Success", "Account created successfully");
      Get.offAllNamed(AppRoutes.home);
    } else {
      Get.snackbar("Error", result.toString());
    }
  }

  Future<void> signIn(String email, String pass) async {
    if (email.isEmpty || pass.isEmpty) {
      Get.snackbar("Error", "Email and password are required");
      return;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar("Invalid Email", "Please enter a valid email address");
      return;
    }

    isLoggingIn.value = true;

    final result = await authService.signIn(email, pass);

    if (result == null) {
      final firebaseUser = fb_auth.FirebaseAuth.instance.currentUser;
      if (firebaseUser != null) {
        final data = await authService.getUser(firebaseUser.uid);
        if (data.docs.isNotEmpty) {
          userObj.value =
              User.fromMap(data.docs.first.data() as Map<String, dynamic>);
        }
      }

      isLoading.value = false;
      Get.snackbar("Success", "Logged in successfully");
      Get.offAllNamed(AppRoutes.home);
    } else {
      Get.snackbar("Login Failed", result.toString());
    }

    isLoggingIn.value = false;
  }

  void signOut() {
    authService.signOut();
    userObj.value = null;
    Get.snackbar("Success", "Signed out");
  }
}
