import 'package:flutter/material.dart';

class AuthBottomText extends StatelessWidget {
  final String message;
  final String clickableText;
  final VoidCallback onTap;

  const AuthBottomText({
    super.key,
    required this.message,
    required this.clickableText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(message),
        GestureDetector(
          onTap: onTap,
          child: Text(
            clickableText,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
