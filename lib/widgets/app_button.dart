import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool outlined;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.outlined = false,
  });

  static const orange = Color(0xFFFFA800);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 39,
      child: outlined
          ? OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                foregroundColor: orange,
                side: const BorderSide(color: orange),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              ),
              child: Text(text, style: const TextStyle(fontSize: 12)),
            )
          : ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: orange,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              ),
              child: Text(text, style: const TextStyle(fontSize: 12)),
            ),
    );
  }
}
