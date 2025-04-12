// logout_confirmation_dialog.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/app/api_servises/firebase_auth_api.dart';
import 'package:newsapp/app/routes/app_routes.dart';
import 'package:newsapp/app/utils/app_theme.dart';

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
          child: const Text("Cancel",
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w600
          ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            service.signOut();
            Get.offAllNamed(AppRoutes.signin);
            Get.snackbar("Logout", "You have been logged out.");
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.background,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text("Logout"),
        ),
      ],
    );
  }
}
