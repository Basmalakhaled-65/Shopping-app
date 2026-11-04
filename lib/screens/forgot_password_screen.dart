import 'package:flutter/material.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, leading: const BackButton(color: Colors.black)),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 18, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(child: Text('Forget Password', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600))),
            const SizedBox(height: 32),
            const AppTextField(label: 'Email', hint: 'example@gmail.com'),
            const SizedBox(height: 20),
            AppButton(text: 'Send', onPressed: () => Navigator.pushNamed(context, '/otp')),
            const Spacer(),
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
    );
  }
}
