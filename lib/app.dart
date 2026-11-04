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
import 'screens/onboarding_screen.dart';
import 'screens/home_screen.dart';
import 'screens/category_screen.dart';
import 'screens/product_details_screen.dart';
import 'screens/search_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/favourite_screen.dart';
import 'screens/account_screen.dart';
import 'models/product.dart';

class ShoppingApp extends StatelessWidget {
  const ShoppingApp({super.key});
  @override Widget build(BuildContext context) => MaterialApp(debugShowCheckedModeBanner: false, title: 'Shopping', theme: ThemeData(useMaterial3: false, scaffoldBackgroundColor: const Color(0xFFF4F4F4), colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFFA800)), appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFF4F4F4), elevation: 0, foregroundColor: Colors.black)), initialRoute: '/', onGenerateRoute: (settings) {
    switch (settings.name) {
      case '/': return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/welcome': return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case '/onboarding1': return MaterialPageRoute(builder: (_) => const OnboardingScreen(page: 1));
      case '/onboarding2': return MaterialPageRoute(builder: (_) => const OnboardingScreen(page: 2));
      case '/signup': return MaterialPageRoute(builder: (_) => const SignupScreen());
      case '/login': return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/forgot': return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case '/otp': return MaterialPageRoute(builder: (_) => const OtpScreen());
      case '/reset': return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());
      case '/cart-empty': return MaterialPageRoute(builder: (_) => const EmptyCartScreen());
      case '/favourite-empty': return MaterialPageRoute(builder: (_) => const EmptyFavouriteScreen());
      case '/home': return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/categories': return MaterialPageRoute(builder: (_) => CategoryScreen(category: settings.arguments as String?));
      case '/details': return MaterialPageRoute(builder: (_) => ProductDetailsScreen(product: settings.arguments is Product ? settings.arguments as Product : null));
      case '/search': return MaterialPageRoute(builder: (_) => const SearchScreen());
      case '/cart': return MaterialPageRoute(builder: (_) => const CartScreen());
      case '/favourites': return MaterialPageRoute(builder: (_) => const FavouriteScreen());
      case '/account': return MaterialPageRoute(builder: (_) => const AccountScreen());
      default: return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  });
}