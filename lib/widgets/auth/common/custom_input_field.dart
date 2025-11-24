import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final IconData icon;
  final TextEditingController controller;
  final bool obscureText;
  final String? errorText; // 👈 adicionamos isso

  const CustomInputField({
    super.key,
    required this.label,
    required this.icon,
    required this.controller,
    this.obscureText = false,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: errorText != null ? Colors.red : Colors.black54,
        ),
        errorText: errorText, // 👈 exibe a mensagem de erro
        prefixIcon: Icon(
          icon,
          color: errorText != null ? Colors.red : Colors.black54,
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: errorText != null ? Colors.red : Colors.black87,
            width: 1.4,
          ),
        ),
      ),
    );
  }
}
