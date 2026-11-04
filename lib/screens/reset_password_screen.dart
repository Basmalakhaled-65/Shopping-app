import 'package:flutter/material.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, leading: const BackButton(color: Colors.black)),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 18, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(child: Text('Reset Password', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600))),
            const SizedBox(height: 32),
            const AppTextField(label: 'Password', hint: '••••••••', isPassword: true, keyboardType: TextInputType.visiblePassword),
            const SizedBox(height: 17),
            const AppTextField(label: 'Confirm Password', hint: '••••••••', isPassword: true, keyboardType: TextInputType.visiblePassword),
            const SizedBox(height: 20),
            AppButton(text: 'Send', onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false)),
          ],
        ),
      ),
    );
  }
}
