import 'package:aiyurapp/widgets/auth/common/auth_buttom_text.dart';
import 'package:flutter/material.dart';
import '../auth/common/auth_page_layout.dart';
import '../auth/common/custom_input_field.dart';
import '../auth/common/primary_button.dart';
import 'login_page.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return AuthPageLayout(
      title: "Create Account",
      child: Column(
        children: [
          const Text(
            "Join us today!",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 32),

          CustomInputField(
            label: "Full Name",
            icon: Icons.person_outline,
            controller: nameController,
          ),
          const SizedBox(height: 16),

          CustomInputField(
            label: "Email",
            icon: Icons.email_outlined,
            controller: emailController,
          ),
          const SizedBox(height: 16),

          CustomInputField(
            label: "Password",
            icon: Icons.lock_outline,
            controller: passwordController,
            obscureText: true,
          ),
          const SizedBox(height: 24),

          PrimaryButton(
            text: "Sign Up",
            onPressed: () {
              Navigator.pop(context); // Remove RegisterPage
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          const SizedBox(height: 16),

          AuthBottomText(
            message: "Already have an account? ",
            clickableText: "Login",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
