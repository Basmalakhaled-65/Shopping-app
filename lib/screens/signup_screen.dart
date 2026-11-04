import 'package:flutter/material.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

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
              const Center(child: Text('Sign up', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600))),
              const SizedBox(height: 24),
              const AppTextField(label: 'Email', hint: 'example@gmail.com'),
              const SizedBox(height: 17),
              const AppTextField(label: 'Password', hint: '••••••••', isPassword: true, keyboardType: TextInputType.visiblePassword),
              const SizedBox(height: 17),
              const AppTextField(label: 'Confirm password', hint: '••••••••', isPassword: true, keyboardType: TextInputType.visiblePassword),
              const SizedBox(height: 20),
              AppButton(text: 'Sign up', onPressed: () => Navigator.pushNamed(context, '/login')),
              const SizedBox(height: 85),
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/login'),
                  child: const Text.rich(TextSpan(children: [
                    TextSpan(text: 'Already have an account? ', style: TextStyle(fontSize: 10)),
                    TextSpan(text: 'Login', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
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
