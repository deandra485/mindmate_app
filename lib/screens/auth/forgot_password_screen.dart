import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:application_belajar/controllers/auth_controller.dart';
import 'package:application_belajar/screens/auth/auth_widgets.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

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
                    const SizedBox(height: 16),

                    // ── App Bar ──
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            child: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Color(0xFF1F2937),
                              size: 20,
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Text(
                            'Forgot Password',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1F2937),
                            ),
                          ),
                        ),
                        const SizedBox(width: 36),
                      ],
                    ),

                    const SizedBox(height: 48),

                    // ── Subtitle ──
                    const Text(
                      'Enter Email Address',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1F2937),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ── Email field ──
                    AuthTextField(
                      controller: controller.forgotEmail,
                      hintText: 'Email Addres',
                      prefixIcon: Icons.mail_outline_rounded,
                      keyboardType: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 16),

                    // ── Back to Sign In ──
                    Center(
                      child: TextButton(
                        onPressed: () => Get.back(),
                        child: const Text(
                          'Back to Sign In',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF374151),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ── Send to Email button ──
                    AuthPrimaryButton(
                      text: 'Send to Email',
                      onPressed: controller.handleForgotPassword,
                    ),

                    const SizedBox(height: 32),

                    // ── Or Login with divider ──
                    const AuthOrDivider(),

                    const SizedBox(height: 24),

                    // ── Social login buttons ──
                    const AuthSocialRow(),

                    const SizedBox(height: 48),

                    // ── Don't have an account? + Sign Up button ──
                    const Center(
                      child: Text(
                        "Don't have an account ?",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    AuthOutlinedButton(
                      text: 'Sign Up',
                      onPressed: () => Get.toNamed('/signup'),
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
