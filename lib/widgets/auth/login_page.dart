import 'package:aiyurapp/services/tmdb_service.dart';
import 'package:aiyurapp/controllers/authentication_controller.dart';
import 'package:aiyurapp/widgets/auth/common/auth_buttom_text.dart';
import 'package:aiyurapp/widgets/auth/common/auth_page_layout.dart';
import 'package:aiyurapp/widgets/auth/common/custom_input_field.dart';
import 'package:aiyurapp/widgets/auth/common/primary_button.dart';
import 'package:aiyurapp/widgets/auth/register_page.dart';
import 'package:flutter/material.dart';

final tmdb = TmdbService();

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return AuthPageLayout(
      title: "Login",
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Welcome back!",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 32),

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
            text: "Login",
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          const SizedBox(height: 16),

          AuthBottomText(
            message: "Don't have an account? ",
            clickableText: "Sign up",
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RegisterPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
