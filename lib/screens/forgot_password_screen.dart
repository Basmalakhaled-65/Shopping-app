import 'package:flutter/material.dart';
import '../presentation/facades/auth_service.dart';
import '../core/network/api_client.dart';
import '../widgets/app_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget { const ForgotPasswordScreen({super.key}); @override State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState(); }
class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final email = TextEditingController(); bool loading = false;
  @override void dispose() { email.dispose(); super.dispose(); }
  Future<void> send() async { if (email.text.trim().isEmpty) { _msg('Enter your email'); return; } setState(() => loading = true); try { await AuthService.sendResetCode(email.text.trim()); if (!mounted) return; Navigator.pushNamed(context, '/otp'); } catch (e) { _msg(ApiClient.errorMessage(e)); } finally { if (mounted) setState(() => loading = false); } }
  void _msg(String s) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(s)));
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, leading: const BackButton(color: Colors.black)), body: Padding(padding: const EdgeInsets.fromLTRB(24, 18, 24, 24), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Center(child: Text('Forget Password', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600))), const SizedBox(height: 32), AppTextField(label: 'Email', hint: 'example@gmail.com', controller: email), const SizedBox(height: 20), SizedBox(width: double.infinity, height: 39, child: ElevatedButton(onPressed: loading ? null : send, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFA800), elevation: 0), child: Text(loading ? 'Please wait...' : 'Send'))), const Spacer(), Center(child: GestureDetector(onTap: () => Navigator.pushNamed(context, '/signup'), child: const Text.rich(TextSpan(children: [TextSpan(text: "Don't have an account? ", style: TextStyle(fontSize: 10)), TextSpan(text: 'Sign up', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))]))))])));
}