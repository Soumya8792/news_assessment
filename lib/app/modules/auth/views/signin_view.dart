import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/app/utils/app_theme.dart';
import '../../../routes/app_routes.dart';
import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/widgets/custome_textfiled.dart';
import '../controller/auth_controller.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DotLottieLoader.fromAsset(
                  "assets/animations/signin.lottie",
                  frameBuilder: (BuildContext context, DotLottie? dotlottie) {
                    if (dotlottie != null && dotlottie.animations.isNotEmpty) {
                      return Center(
                        child: SizedBox(
                          height: 250,
                          child: Lottie.memory(
                            dotlottie.animations.values.first,
                            fit: BoxFit.contain,
                            repeat: true,
                          ),
                        ),
                      );
                    } else {
                      return const Center(
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      );
                    }
                  },
                ),

                /// Welcome Text
                Text(
                  "Welcome Back!",
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  "Login to your account",
                  style: TextStyle(fontSize: 16, color: AppColors.grey),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),

                /// Email
                buildTextField(_emailController, "Email", Icons.email),
                SizedBox(height: 20),

                /// Password
                buildTextField(_passwordController, "Password", Icons.lock,
                    isPassword: true),
                SizedBox(height: 30),

                /// Login Button
                Obx(() {
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller.isLoggingIn.value
                          ? null
                          : () {
                              controller.signIn(
                                _emailController.text,
                                _passwordController.text,
                              );
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: controller.isLoggingIn.value
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              "Login",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                    ),
                  );
                }),

                SizedBox(height: 20),

                /// Don't have an account? Sign Up
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?",
                        style: TextStyle(color: Colors.black87)),
                    TextButton(
                      onPressed: () => Get.toNamed(AppRoutes.signup),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            color: AppColors.primary,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
