import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/login_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/otp_screen.dart';
import 'screens/reset_password_screen.dart';
import 'screens/empty_cart_screen.dart';
import 'screens/empty_favourite_screen.dart';

class ShoppingApp extends StatelessWidget {
  const ShoppingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping',
      theme: ThemeData(
        useMaterial3: false,
        scaffoldBackgroundColor: const Color(0xFFF4F4F4),
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFFA800)),
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const SplashScreen(),
        '/welcome': (_) => const WelcomeScreen(),
        '/signup': (_) => const SignupScreen(),
        '/login': (_) => const LoginScreen(),
        '/forgot': (_) => const ForgotPasswordScreen(),
        '/otp': (_) => const OtpScreen(),
        '/reset': (_) => const ResetPasswordScreen(),
        '/cart-empty': (_) => const EmptyCartScreen(),
        '/favourite-empty': (_) => const EmptyFavouriteScreen(),
      },
    );
  }
}
