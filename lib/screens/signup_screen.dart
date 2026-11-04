import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/api_service.dart';
import '../widgets/app_text_field.dart';

class SignupScreen extends StatefulWidget { const SignupScreen({super.key}); @override State<SignupScreen> createState() => _SignupScreenState(); }
class _SignupScreenState extends State<SignupScreen> {
  final name = TextEditingController(); final phone = TextEditingController(); final email = TextEditingController(); final password = TextEditingController(); final confirm = TextEditingController(); bool loading = false;
  @override void dispose() { name.dispose(); phone.dispose(); email.dispose(); password.dispose(); confirm.dispose(); super.dispose(); }
  void message(String s) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(s)));
  Future<void> signup() async {
    if ([name.text, phone.text, email.text, password.text, confirm.text].any((e) => e.trim().isEmpty)) { message('Please fill in all fields'); return; }
    if (password.text != confirm.text) { message('Passwords do not match'); return; }
    setState(() => loading = true);
    try { await AuthService.signUp(name: name.text.trim(), phone: phone.text.trim(), email: email.text.trim(), password: password.text, confirmPassword: confirm.text); if (!mounted) return; message('Account created. Please login.'); Navigator.pushReplacementNamed(context, '/login'); }
    catch (e) { message(ApiService.errorMessage(e)); }
    finally { if (mounted) setState(() => loading = false); }
  }
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, leading: const BackButton(color: Colors.black)), body: SafeArea(child: SingleChildScrollView(padding: const EdgeInsets.fromLTRB(24, 12, 24, 20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Center(child: Text('Sign up', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600))), const SizedBox(height: 24), AppTextField(label: 'Name', hint: 'Your name', controller: name, keyboardType: TextInputType.name), const SizedBox(height: 17), AppTextField(label: 'Phone', hint: '01xxxxxxxxx', controller: phone, keyboardType: TextInputType.phone), const SizedBox(height: 17), AppTextField(label: 'Email', hint: 'example@gmail.com', controller: email), const SizedBox(height: 17), AppTextField(label: 'Password', hint: '••••••••', isPassword: true, keyboardType: TextInputType.visiblePassword, controller: password), const SizedBox(height: 17), AppTextField(label: 'Confirm password', hint: '••••••••', isPassword: true, keyboardType: TextInputType.visiblePassword, controller: confirm), const SizedBox(height: 20), SizedBox(width: double.infinity, height: 39, child: ElevatedButton(onPressed: loading ? null : signup, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFA800), elevation: 0), child: Text(loading ? 'Please wait...' : 'Sign up', style: const TextStyle(fontSize: 12)))), const SizedBox(height: 65), Center(child: GestureDetector(onTap: () => Navigator.pushNamed(context, '/login'), child: const Text.rich(TextSpan(children: [TextSpan(text: 'Already have an account? ', style: TextStyle(fontSize: 10)), TextSpan(text: 'Login', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))]))))]))));
}