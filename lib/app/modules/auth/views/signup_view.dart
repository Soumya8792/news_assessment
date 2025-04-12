import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:newsapp/app/utils/app_theme.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/widgets/custome_textfiled.dart';
import '../controller/auth_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _locationController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Lottie Animation
                Center(
                  child: DotLottieLoader.fromAsset(
                    "assets/animations/signin.lottie",
                    frameBuilder: (context, dotlottie) {
                      if (dotlottie != null &&
                          dotlottie.animations.isNotEmpty) {
                        return SizedBox(
                          height: 160,
                          child: Lottie.memory(
                            dotlottie.animations.values.first,
                            repeat: true,
                          ),
                        );
                      }
                      return const SizedBox(
                        width: 40,
                        height: 40,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 10),
                Center(
                  child: Text(
                    "Create Your Account",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                /// Name Field
                buildTextField(_nameController, "Full Name", Icons.person),

                /// Email Field
                buildTextField(_emailController, "Email", Icons.email),

                /// Mobile No Field
                buildTextField(_mobileController, "Mobile Number", Icons.phone,
                    inputType: TextInputType.phone),

                /// Location Field
                buildTextField(
                    _locationController, "Location", Icons.location_on),

                /// Password Field
                buildTextField(_passwordController, "Password", Icons.lock,
                    isPassword: true),

                /// Confirm Password Field
                buildTextField(_confirmPasswordController, "Confirm Password",
                    Icons.lock_outline,
                    isPassword: true),

                const SizedBox(height: 30),

                /// Sign Up Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.signUp(
                        _nameController.text,
                        _emailController.text,
                        _mobileController.text,
                        _locationController.text,
                        _passwordController.text,
                        _confirmPasswordController.text,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?",
                        style: TextStyle(color: Colors.black87)),
                    TextButton(
                      onPressed: () => Get.toNamed(AppRoutes.signin),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: AppColors.primary,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w600,
                        ),
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
