import 'package:flutter/material.dart';
import '../services/user_service.dart';
import '../services/api_service.dart';
import '../widgets/shop_bottom_nav.dart';

class AccountScreen extends StatefulWidget { const AccountScreen({super.key}); @override State<AccountScreen> createState() => _AccountScreenState(); }
class _AccountScreenState extends State<AccountScreen> {
  final name = TextEditingController(); final email = TextEditingController(); final phone = TextEditingController(); final address = TextEditingController(); bool loading = true; bool saving = false;
  @override void initState() { super.initState(); load(); }
  @override void dispose() { name.dispose(); email.dispose(); phone.dispose(); address.dispose(); super.dispose(); }
  Future<void> load() async { try { final data = await UserService.getProfile(); name.text = (data['name'] ?? '').toString(); email.text = (data['email'] ?? '').toString(); phone.text = (data['phone'] ?? '').toString(); address.text = (data['address'] ?? '').toString(); } catch (e) { if (mounted) _msg(ApiService.errorMessage(e)); } finally { if (mounted) setState(() => loading = false); } }
  Future<void> save() async { setState(() => saving = true); try { await UserService.updateProfile(name: name.text.trim(), phone: phone.text.trim(), address: address.text.trim()); if (!mounted) return; _msg('Profile updated'); } catch (e) { _msg(ApiService.errorMessage(e)); } finally { if (mounted) setState(() => saving = false); } }
  void _msg(String s) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(s)));
  Widget field(String label, TextEditingController c, {bool readOnly = false, TextInputType type = TextInputType.text}) => Padding(padding: const EdgeInsets.only(bottom: 12), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: const TextStyle(fontSize: 11)), const SizedBox(height: 5), TextField(controller: c, readOnly: readOnly, keyboardType: type, decoration: const InputDecoration(isDense: true, border: OutlineInputBorder()))]));
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Account', style: TextStyle(fontSize: 16)), centerTitle: true), body: loading ? const Center(child: CircularProgressIndicator()) : ListView(padding: const EdgeInsets.all(16), children: [const Center(child: CircleAvatar(radius: 45, backgroundColor: Color(0xFFDADADA), child: Icon(Icons.person, size: 55, color: Colors.grey))), const SizedBox(height: 20), field('Name', name), field('Email', email, readOnly: true), field('Phone', phone, type: TextInputType.phone), field('Address', address), ElevatedButton(onPressed: saving ? null : save, style: ElevatedButton.styleFrom(backgroundColor: Colors.black), child: Text(saving ? 'Saving...' : 'Submit'))]), bottomNavigationBar: const ShopBottomNav(selected: 3));
}