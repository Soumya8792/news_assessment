import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/app/utils/app_theme.dart';
import '../../auth/controller/auth_controller.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final user = authController.userObj.value;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.white),
        title: const Text(
          'User Profile',
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
      ),
      body: user == null
          ? const Center(child: Text("No user info available"))
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    color: AppColors.primary,
                    child: Column(
                      children: [
                        const CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.person,
                              size: 40, color: AppColors.primary),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          user.fname ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          user.email ?? '',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        _buildInfoCard(
                            Icons.person, 'Full Name', user.fname ?? ''),
                        _buildInfoCard(Icons.email, 'Email', user.email ?? ''),
                        _buildInfoCard(Icons.phone, 'Mobile', user.mob ?? ''),
                        _buildInfoCard(
                            Icons.location_on, 'Location', user.loc ?? ''),
                        // Add more cards as needed
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildInfoCard(IconData icon, String title, String value) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title),
        subtitle: Text(value.isNotEmpty ? value : 'Not available'),
      ),
    );
  }
}
