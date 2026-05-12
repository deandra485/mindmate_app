import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:application_belajar/controllers/auth_controller.dart';
import 'package:application_belajar/screens/auth/auth_widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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

                    // ── Welcome title ──
                    const Text(
                      'Welcome 👋',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1F2937),
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Log in to continue to your account',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF6B7280),
                        height: 1.4,
                      ),
                    ),

                    const SizedBox(height: 36),

                    // ── Email field ──
                    AuthTextField(
                      controller: controller.loginEmail,
                      hintText: 'Email Addres',
                      prefixIcon: Icons.mail_outline_rounded,
                      keyboardType: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 18),

                    // ── Password field ──
                    Obx(
                      () => AuthTextField(
                        controller: controller.loginPassword,
                        hintText: 'Password',
                        prefixIcon: Icons.lock_outline_rounded,
                        obscureText: controller.loginObscure.value,
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.loginObscure.value
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: const Color(0xFF9CA3AF),
                            size: 20,
                          ),
                          onPressed: controller.toggleLoginObscure,
                        ),
                      ),
                    ),

                    // ── Forgot Password ──
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => Get.toNamed('/forgot-password'),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 8,
                          ),
                        ),
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF374151),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ── Log In button ──
                    AuthPrimaryButton(
                      text: 'Log In',
                      onPressed: controller.handleLogin,
                    ),

                    const SizedBox(height: 28),

                    // ── Or Login with divider ──
                    const AuthOrDivider(),

                    const SizedBox(height: 24),

                    // ── Social login buttons ──
                    const AuthSocialRow(),

                    const SizedBox(height: 36),

                    // ── Don't have an account? Sign Up ──
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account ? ",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF6B7280),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Get.toNamed('/signup'),
                            child: const Text(
                              'Sign Up',
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
