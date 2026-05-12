import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:application_belajar/controllers/auth_controller.dart';
import 'package:application_belajar/screens/auth/auth_widgets.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

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
                            'Verification',
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

                    // ── Enter New Password ──
                    const Text(
                      'Enter New Password',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1F2937),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ── Password field ──
                    Obx(
                      () => AuthTextField(
                        controller: controller.newPassword,
                        hintText: 'Password',
                        prefixIcon: Icons.lock_outline_rounded,
                        obscureText: controller.newPasswordObscure.value,
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.newPasswordObscure.value
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: const Color(0xFF9CA3AF),
                            size: 20,
                          ),
                          onPressed: controller.toggleNewPasswordObscure,
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // ── Confirm New Password ──
                    const Text(
                      'Confirm New Password',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1F2937),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ── Confirm Password field ──
                    Obx(
                      () => AuthTextField(
                        controller: controller.confirmNewPassword,
                        hintText: 'Confirm Password',
                        prefixIcon: Icons.lock_outline_rounded,
                        obscureText: controller.confirmNewPasswordObscure.value,
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.confirmNewPasswordObscure.value
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: const Color(0xFF9CA3AF),
                            size: 20,
                          ),
                          onPressed:
                              controller.toggleConfirmNewPasswordObscure,
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // ── Save Password button ──
                    AuthPrimaryButton(
                      text: 'Save Password',
                      onPressed: controller.handleSaveNewPassword,
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
