import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/api_service.dart';
import '../widgets/app_text_field.dart';

class ResetPasswordScreen extends StatefulWidget { const ResetPasswordScreen({super.key}); @override State<ResetPasswordScreen> createState() => _ResetPasswordScreenState(); }
class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final password = TextEditingController(); final confirm = TextEditingController(); bool loading = false;
  @override void dispose() { password.dispose(); confirm.dispose(); super.dispose(); }
  Future<void> reset() async { if (password.text.isEmpty || confirm.text.isEmpty) { _msg('Fill in both password fields'); return; } if (password.text != confirm.text) { _msg('Passwords do not match'); return; } setState(() => loading = true); try { await AuthService.resetPassword(password.text, confirm.text); if (!mounted) return; _msg('Password changed successfully'); Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false); } catch (e) { _msg(ApiService.errorMessage(e)); } finally { if (mounted) setState(() => loading = false); } }
  void _msg(String s) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(s)));
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, leading: const BackButton(color: Colors.black)), body: Padding(padding: const EdgeInsets.fromLTRB(24, 18, 24, 24), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Center(child: Text('Reset Password', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600))), const SizedBox(height: 32), AppTextField(label: 'Password', hint: '••••••••', isPassword: true, keyboardType: TextInputType.visiblePassword, controller: password), const SizedBox(height: 17), AppTextField(label: 'Confirm Password', hint: '••••••••', isPassword: true, keyboardType: TextInputType.visiblePassword, controller: confirm), const SizedBox(height: 20), SizedBox(width: double.infinity, height: 39, child: ElevatedButton(onPressed: loading ? null : reset, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFA800), elevation: 0), child: Text(loading ? 'Please wait...' : 'Send')))])));
}