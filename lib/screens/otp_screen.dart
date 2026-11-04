import 'package:flutter/material.dart';
import '../widgets/app_button.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, leading: const BackButton(color: Colors.black)),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 18, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(child: Text('OTP', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600))),
            const SizedBox(height: 34),
            const Text('Enter Four Number', style: TextStyle(fontSize: 11)),
            const SizedBox(height: 12),
            Row(
              children: List.generate(4, (index) => Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: index == 3 ? 0 : 8),
                  child: TextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    decoration: InputDecoration(
                      counterText: '',
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
              )),
            ),
            const SizedBox(height: 20),
            AppButton(text: 'Confirm', onPressed: () => Navigator.pushNamed(context, '/reset')),
          ],
        ),
      ),
    );
  }
}
