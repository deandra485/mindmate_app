import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:application_belajar/config/theme.dart';
import 'package:application_belajar/providers/app_provider.dart';
import 'package:application_belajar/controllers/auth_controller.dart';
import 'package:application_belajar/screens/onboarding/splash_screen.dart';
import 'package:application_belajar/screens/onboarding/onboarding_screen.dart';
import 'package:application_belajar/screens/auth/login_screen.dart';
import 'package:application_belajar/screens/auth/signup_screen.dart';
import 'package:application_belajar/screens/auth/forgot_password_screen.dart';
import 'package:application_belajar/screens/auth/verification_screen.dart';
import 'package:application_belajar/screens/auth/new_password_screen.dart';
import 'package:application_belajar/screens/main_screen.dart';
import 'package:application_belajar/screens/tasks/add_task_screen.dart';
import 'package:application_belajar/screens/tasks/note_screen.dart';
import 'package:application_belajar/screens/profile/edit_profile_screen.dart';
import 'package:application_belajar/screens/settings/settings_screen.dart';
import 'package:application_belajar/screens/profile/change_password_screen.dart';
import 'package:application_belajar/screens/profile/change_email_screen.dart';
import 'package:application_belajar/screens/settings/app_version_screen.dart';
import 'package:application_belajar/screens/settings/privacy_policy_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Register GetX controllers
  Get.put(AuthController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AppProvider())],
      child: GetMaterialApp(
        title: 'Mindmate',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
        getPages: [
          GetPage(name: '/onboarding', page: () => const OnboardingScreen()),
          GetPage(name: '/login', page: () => const LoginScreen()),
          GetPage(name: '/signup', page: () => const SignupScreen()),
          GetPage(
            name: '/forgot-password',
            page: () => const ForgotPasswordScreen(),
          ),
          GetPage(
            name: '/verification',
            page: () => const VerificationScreen(),
          ),
          GetPage(
            name: '/new-password',
            page: () => const NewPasswordScreen(),
          ),
          GetPage(name: '/main', page: () => const MainScreen()),
          GetPage(name: '/add-task', page: () => const AddTaskScreen()),
          GetPage(name: '/note', page: () => const NoteScreen()),
          GetPage(
            name: '/edit-profile',
            page: () => const EditProfileScreen(),
          ),
          GetPage(name: '/settings', page: () => const SettingsScreen()),
          GetPage(
            name: '/change-password',
            page: () => const ChangePasswordScreen(),
          ),
          GetPage(
            name: '/change-email',
            page: () => const ChangeEmailScreen(),
          ),
          GetPage(
            name: '/app-version',
            page: () => const AppVersionScreen(),
          ),
          GetPage(
            name: '/privacy-policy',
            page: () => const PrivacyPolicyScreen(),
          ),
        ],
      ),
    );
  }
}
