import 'package:aiyurapp/services/authentication_service.dart';
import 'package:aiyurapp/widgets/auth/common/auth_buttom_text.dart';
import 'package:aiyurapp/widgets/auth/common/auth_page_layout.dart';
import 'package:aiyurapp/widgets/auth/common/custom_input_field.dart';
import 'package:aiyurapp/widgets/auth/common/primary_button.dart';
import 'package:aiyurapp/widgets/auth/login_page.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? emailError;
  String? passwordError;
  String? nameError;

  @override
  Widget build(BuildContext context) {
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
            errorText: nameError, // 👈 exibindo erro
          ),
          const SizedBox(height: 16),

          CustomInputField(
            label: "Email",
            icon: Icons.email_outlined,
            controller: emailController,
            errorText: emailError, // 👈 exibindo erro
          ),
          const SizedBox(height: 16),

          CustomInputField(
            label: "Password",
            icon: Icons.lock_outline,
            controller: passwordController,
            obscureText: true,
            errorText: passwordError, // 👈 exibindo erro
          ),
          const SizedBox(height: 24),

          PrimaryButton(
            text: "Sign Up",
            onPressed: () async {
              setState(() {
                emailError = null;
                passwordError = null;
              });

              final email = emailController.text.trim();
              final password = passwordController.text;
              final name = nameController.text;

              final result = await createUserWithEmailAndPassword(email, password);

              if (result != null) {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/home');
              } else {
                setState(() {
                  // 👇 Mostra erro visual
                  emailError = "Email inválido ou já utilizado";
                  passwordError = "Senha muito fraca ou inválida";
                });

                // opcional: snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Erro ao criar usuário"),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),

          const SizedBox(height: 16),

          AuthBottomText(
            message: "Already have an account? ",
            clickableText: "Login",
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginPage()));
            },
          ),
        ],
      ),
    );
  }
}
