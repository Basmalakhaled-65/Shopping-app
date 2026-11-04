import 'package:flutter/material.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, leading: const BackButton(color: Colors.black)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(child: Text('Login', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600))),
              const SizedBox(height: 24),
              const AppTextField(label: 'Email', hint: 'example@gmail.com'),
              const SizedBox(height: 17),
              const AppTextField(label: 'Password', hint: '••••••••', isPassword: true, keyboardType: TextInputType.visiblePassword),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/forgot'),
                  child: const Text('Forget password?', style: TextStyle(fontSize: 10, color: Colors.grey)),
                ),
              ),
              AppButton(text: 'Login', onPressed: () => Navigator.pushNamed(context, '/cart-empty')),
              const SizedBox(height: 100),
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/signup'),
                  child: const Text.rich(TextSpan(children: [
                    TextSpan(text: "Don't have an account? ", style: TextStyle(fontSize: 10)),
                    TextSpan(text: 'Sign up', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                  ])),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
