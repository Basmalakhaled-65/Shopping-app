import 'package:flutter/material.dart';
import '../presentation/facades/auth_service.dart';
import '../core/network/api_client.dart';
import '../widgets/app_text_field.dart';

class LoginScreen extends StatefulWidget { const LoginScreen({super.key}); @override State<LoginScreen> createState() => _LoginScreenState(); }
class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController(); final password = TextEditingController(); bool loading = false;
  @override void dispose() { email.dispose(); password.dispose(); super.dispose(); }
  Future<void> login() async {
    if (email.text.trim().isEmpty || password.text.isEmpty) { _message('Enter email and password'); return; }
    setState(() => loading = true);
    try { await AuthService.signIn(email: email.text.trim(), password: password.text); if (!mounted) return; Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false); }
    catch (e) { _message(ApiClient.errorMessage(e)); }
    finally { if (mounted) setState(() => loading = false); }
  }
  void _message(String text) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, leading: const BackButton(color: Colors.black)), body: SafeArea(child: SingleChildScrollView(padding: const EdgeInsets.fromLTRB(24, 12, 24, 20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Center(child: Text('Login', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600))), const SizedBox(height: 24), AppTextField(label: 'Email', hint: 'example@gmail.com', controller: email), const SizedBox(height: 17), AppTextField(label: 'Password', hint: '••••••••', isPassword: true, keyboardType: TextInputType.visiblePassword, controller: password), Align(alignment: Alignment.centerRight, child: TextButton(onPressed: () => Navigator.pushNamed(context, '/forgot'), child: const Text('Forget password?', style: TextStyle(fontSize: 10, color: Colors.grey)))), SizedBox(width: double.infinity, height: 39, child: ElevatedButton(onPressed: loading ? null : login, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFA800), elevation: 0), child: Text(loading ? 'Please wait...' : 'Login', style: const TextStyle(fontSize: 12)))), const SizedBox(height: 100), Center(child: GestureDetector(onTap: () => Navigator.pushNamed(context, '/signup'), child: const Text.rich(TextSpan(children: [TextSpan(text: "Don't have an account? ", style: TextStyle(fontSize: 10)), TextSpan(text: 'Sign up', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))]))))]))));
}