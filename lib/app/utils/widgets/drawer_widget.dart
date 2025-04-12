import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/app/api_servises/firebase_auth_api.dart';
import 'package:newsapp/app/utils/widgets/logout_confirmation_dialog.dart';
import '../../modules/auth/controller/auth_controller.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final FirebaseAuthAPI service = FirebaseAuthAPI();
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Obx(() {
        final user = authController.userObj.value;

        return ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.blueAccent),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child:
                        Icon(Icons.person, size: 35, color: Colors.blueAccent),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    user != null ? 'Hello, ${user.fname}' : 'Hello, User!',
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    user?.email ?? '',
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                // Navigate to home or do something
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Navigate to settings or do something
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => LogoutConfirmationDialog(service: service),
                );
              },
            ),
          ],
        );
      }),
    );
  }
}
