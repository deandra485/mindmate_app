import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  // ── Login ──
  final loginEmail = TextEditingController();
  final loginPassword = TextEditingController();
  final loginObscure = true.obs;

  // ── Sign Up ──
  final signupUsername = TextEditingController();
  final signupEmail = TextEditingController();
  final signupPassword = TextEditingController();
  final signupConfirmPassword = TextEditingController();
  final signupObscure = true.obs;
  final signupConfirmObscure = true.obs;

  // ── Forgot Password ──
  final forgotEmail = TextEditingController();

  // ── Verification Code ──
  final verificationCodes = List.generate(4, (_) => TextEditingController());

  // ── New Password ──
  final newPassword = TextEditingController();
  final confirmNewPassword = TextEditingController();
  final newPasswordObscure = true.obs;
  final confirmNewPasswordObscure = true.obs;

  // ── Loading state ──
  final isLoading = false.obs;

  // ─────────────────────────────────────────────────
  // ACTIONS
  // ─────────────────────────────────────────────────

  void toggleLoginObscure() => loginObscure.value = !loginObscure.value;
  void toggleSignupObscure() => signupObscure.value = !signupObscure.value;
  void toggleSignupConfirmObscure() =>
      signupConfirmObscure.value = !signupConfirmObscure.value;
  void toggleNewPasswordObscure() =>
      newPasswordObscure.value = !newPasswordObscure.value;
  void toggleConfirmNewPasswordObscure() =>
      confirmNewPasswordObscure.value = !confirmNewPasswordObscure.value;

  void handleLogin() {
    if (loginEmail.text.trim().isEmpty || loginPassword.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Silakan isi semua field',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
        margin: const EdgeInsets.all(16),
      );
      return;
    }
    // Navigate to main screen
    Get.offAllNamed('/main');
  }

  void handleSignUp() {
    if (signupUsername.text.trim().isEmpty ||
        signupEmail.text.trim().isEmpty ||
        signupPassword.text.trim().isEmpty ||
        signupConfirmPassword.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Silakan isi semua field',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
        margin: const EdgeInsets.all(16),
      );
      return;
    }
    if (signupPassword.text != signupConfirmPassword.text) {
      Get.snackbar(
        'Error',
        'Password tidak cocok',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
        margin: const EdgeInsets.all(16),
      );
      return;
    }
    // Navigate to main screen after sign up
    Get.offAllNamed('/main');
  }

  void handleForgotPassword() {
    if (forgotEmail.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Silakan masukkan email',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
        margin: const EdgeInsets.all(16),
      );
      return;
    }
    // Navigate to verification screen
    Get.toNamed('/verification');
  }

  void handleVerifyCode() {
    final code = verificationCodes.map((c) => c.text).join();
    if (code.length < 4) {
      Get.snackbar(
        'Error',
        'Silakan masukkan 4 digit kode verifikasi',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
        margin: const EdgeInsets.all(16),
      );
      return;
    }
    // Navigate to new password screen
    Get.toNamed('/new-password');
  }

  void handleResendCode() {
    Get.snackbar(
      'Kode Dikirim',
      'Kode verifikasi baru telah dikirim ke email Anda',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.shade100,
      colorText: Colors.green.shade800,
      margin: const EdgeInsets.all(16),
    );
  }

  void handleSaveNewPassword() {
    if (newPassword.text.trim().isEmpty ||
        confirmNewPassword.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Silakan isi semua field',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
        margin: const EdgeInsets.all(16),
      );
      return;
    }
    if (newPassword.text != confirmNewPassword.text) {
      Get.snackbar(
        'Error',
        'Password tidak cocok',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
        margin: const EdgeInsets.all(16),
      );
      return;
    }
    // Password saved, navigate back to login
    Get.offAllNamed('/login');
    Get.snackbar(
      'Berhasil',
      'Password berhasil diubah. Silakan login kembali.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.shade100,
      colorText: Colors.green.shade800,
      margin: const EdgeInsets.all(16),
    );
  }

  @override
  void onClose() {
    loginEmail.dispose();
    loginPassword.dispose();
    signupUsername.dispose();
    signupEmail.dispose();
    signupPassword.dispose();
    signupConfirmPassword.dispose();
    forgotEmail.dispose();
    for (final c in verificationCodes) {
      c.dispose();
    }
    newPassword.dispose();
    confirmNewPassword.dispose();
    super.onClose();
  }
}
