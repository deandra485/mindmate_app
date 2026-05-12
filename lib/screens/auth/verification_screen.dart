import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:application_belajar/controllers/auth_controller.dart';
import 'package:application_belajar/screens/auth/auth_widgets.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

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

                    // ── Subtitle ──
                    const Text(
                      'Enter Verification Code',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1F2937),
                      ),
                    ),

                    const SizedBox(height: 28),

                    // ── 4 Code Input Fields ──
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(4, (index) {
                        return Container(
                          width: 56,
                          height: 56,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFFE5E7EB),
                              width: 1.5,
                            ),
                          ),
                          child: Center(
                            child: TextField(
                              controller: controller.verificationCodes[index],
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              maxLength: 1,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1F2937),
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: const InputDecoration(
                                counterText: '',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                              ),
                              onChanged: (value) {
                                if (value.isNotEmpty && index < 3) {
                                  FocusScope.of(context).nextFocus();
                                } else if (value.isEmpty && index > 0) {
                                  FocusScope.of(context).previousFocus();
                                }
                              },
                            ),
                          ),
                        );
                      }),
                    ),

                    const SizedBox(height: 20),

                    // ── Resend code ──
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "If you didn't receive a code, ",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF6B7280),
                            ),
                          ),
                          GestureDetector(
                            onTap: controller.handleResendCode,
                            child: const Text(
                              'Resend',
                              style: TextStyle(
                                fontSize: 13,
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

                    // ── Next button ──
                    AuthPrimaryButton(
                      text: 'Next',
                      onPressed: controller.handleVerifyCode,
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
