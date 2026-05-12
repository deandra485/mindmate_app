import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:application_belajar/controllers/auth_controller.dart';
import 'package:application_belajar/screens/auth/auth_widgets.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      body: Stack(
        children: [
          const AuthBackgroundBlobs(),
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 48),

                    // ── Title ──
                    const Text(
                      'Create Your Account',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1F2937),
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Please enter your email account',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF6B7280),
                        height: 1.4,
                      ),
                    ),

                    const SizedBox(height: 36),

                    // ── Username field ──
                    AuthTextField(
                      controller: controller.signupUsername,
                      hintText: 'Username',
                      prefixIcon: Icons.person_outline_rounded,
                    ),

                    const SizedBox(height: 18),

                    // ── Email field ──
                    AuthTextField(
                      controller: controller.signupEmail,
                      hintText: 'Email Addres',
                      prefixIcon: Icons.mail_outline_rounded,
                      keyboardType: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 18),

                    // ── Password field ──
                    Obx(
                      () => AuthTextField(
                        controller: controller.signupPassword,
                        hintText: 'Password',
                        prefixIcon: Icons.lock_outline_rounded,
                        obscureText: controller.signupObscure.value,
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.signupObscure.value
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: const Color(0xFF9CA3AF),
                            size: 20,
                          ),
                          onPressed: controller.toggleSignupObscure,
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // ── Confirm Password field ──
                    Obx(
                      () => AuthTextField(
                        controller: controller.signupConfirmPassword,
                        hintText: 'Confirm Password',
                        prefixIcon: Icons.lock_outline_rounded,
                        obscureText: controller.signupConfirmObscure.value,
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.signupConfirmObscure.value
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: const Color(0xFF9CA3AF),
                            size: 20,
                          ),
                          onPressed: controller.toggleSignupConfirmObscure,
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // ── Sign Up button ──
                    AuthPrimaryButton(
                      text: 'Sign Up',
                      onPressed: controller.handleSignUp,
                    ),

                    const SizedBox(height: 36),

                    // ── Already have an account? Log In ──
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account ? ',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF6B7280),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Get.back(),
                            child: const Text(
                              'Log In',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF7C3AED),
                                decoration: TextDecoration.underline,
                                decorationColor: Color(0xFF7C3AED),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
