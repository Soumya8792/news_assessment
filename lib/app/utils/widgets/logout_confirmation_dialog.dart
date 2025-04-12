// logout_confirmation_dialog.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/app/api_servises/firebase_auth_api.dart';

class LogoutConfirmationDialog extends StatelessWidget {
  final FirebaseAuthAPI service;

  const LogoutConfirmationDialog({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Confirm Logout"),
      content: const Text("Are you sure you want to logout?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            service.signOut();
            Get.offAllNamed(
                "/signin"); // Or AppRoutes.login if using a constant
            Get.snackbar("Logout", "You have been logged out.");
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
          child: const Text("Logout"),
        ),
      ],
    );
  }
}
