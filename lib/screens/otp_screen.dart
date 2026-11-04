
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/api_service.dart';
import '../widgets/app_button.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final fields = List.generate(
    4,
    (_) => TextEditingController(),
  );

  bool loading = false;

  @override
  void dispose() {
    for (final f in fields) {
      f.dispose();
    }
    super.dispose();
  }

  Future<void> confirm() async {
    final code = fields.map((e) => e.text).join();

    if (code.length != 4) {
      _msg('Enter the four-digit code');
      return;
    }

    setState(() => loading = true);

    try {
      await AuthService.activateResetCode(code);

      if (!mounted) return;

      Navigator.pushNamed(context, '/reset');
    } catch (e) {
      _msg(ApiService.errorMessage(e));
    } finally {
      if (mounted) {
        setState(() => loading = false);
      }
    }
  }

  void _msg(String s) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(s)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 18, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'OTP',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 34),

            const Text(
              'Enter Four Number',
              style: TextStyle(fontSize: 11),
            ),

            const SizedBox(height: 12),

            Row(
              children: List.generate(
                4,
                (i) => Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: i == 3 ? 0 : 8,
                    ),
                    child: TextField(
                      controller: fields[i],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      decoration: InputDecoration(
                        counterText: '',
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 12),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            AppButton(
              text: loading ? 'Please wait...' : 'Confirm',
              onPressed: loading ? () {} : confirm,
            ),
          ],
        ),
      ),
    );
  }
}
