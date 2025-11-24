import 'package:flutter/material.dart';

class AuthPageLayout extends StatelessWidget {
  final String title;
  final Widget child;

  const AuthPageLayout({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFFF2F2F2),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(child: child),
        ),
      ),
    );
  }
}
