import 'package:aiyurapp/main.dart';
import 'package:aiyurapp/widgets/auth/common/auth_buttom_text.dart';
import 'package:aiyurapp/widgets/auth/common/auth_page_layout.dart';
import 'package:aiyurapp/widgets/auth/common/custom_input_field.dart';
import 'package:aiyurapp/widgets/auth/common/primary_button.dart';
import 'package:aiyurapp/widgets/auth/register_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? emailError;
  String? passwordError;
  bool loading = false;

  Future<void> onLoginPressed() async {
    // ----------------------------------------
    // 1. Limpa erros iniciais
    // ----------------------------------------
    setState(() {
      emailError = null;
      passwordError = null;
    });

    // ----------------------------------------
    // 2. Valida campos vazios
    // ----------------------------------------
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      setState(() {
        if (emailController.text.trim().isEmpty) {
          emailError = "Email cannot be empty";
        }
        if (passwordController.text.trim().isEmpty) {
          passwordError = "Password cannot be empty";
        }
      });
      return;
    }

    // ----------------------------------------
    // 3. Mostra loading
    // ----------------------------------------
    setState(() => loading = true);

    // ----------------------------------------
    // 4. Login
    // ----------------------------------------
    final result = await authController.signInUserWithEmailAndPassword(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    // ----------------------------------------
    // 5. Para loading
    // ----------------------------------------
    setState(() => loading = false);

    // ----------------------------------------
    // 6. Se deu erro no login
    // ----------------------------------------
    if (result != null) {
      setState(() {
        emailError = "Wrong email or password";
        passwordError = "Wrong email or password";
      });
      return;
    }

    // ----------------------------------------
    // 7. Login OK → navega
    // ----------------------------------------
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
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
            errorText: emailError,
          ),
          const SizedBox(height: 16),

          CustomInputField(
            label: "Password",
            icon: Icons.lock_outline,
            controller: passwordController,
            obscureText: true,
            errorText: passwordError,
          ),
          const SizedBox(height: 24),

          loading
              ? const CircularProgressIndicator()
              : PrimaryButton(text: "Login", onPressed: onLoginPressed),

          const SizedBox(height: 16),

          AuthBottomText(
            message: "Don't have an account? ",
            clickableText: "Sign up",
            onTap: () {
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
