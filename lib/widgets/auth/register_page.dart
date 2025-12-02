import 'package:aiyurapp/controllers/authentication_controller.dart';
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
  final AuthenticationController authenticationModule =
      AuthenticationController();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? emailError;
  String? passwordError;
  String? nameError;

  bool loading = false;

  Future<void> onRegisterPressed() async {
    // ----------------------------
    // 1. Resetar erros
    // ----------------------------
    setState(() {
      emailError = null;
      passwordError = null;
      nameError = null;
    });

    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // ----------------------------
    // 2. Validações
    // ----------------------------
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      setState(() {
        if (name.isEmpty) nameError = "Name cannot be empty";
        if (email.isEmpty) emailError = "Email cannot be empty";
        if (password.isEmpty) passwordError = "Password cannot be empty";
      });
      return;
    }

    // ----------------------------
    // 3. Exibe loading
    // ----------------------------
    setState(() => loading = true);

    // ----------------------------
    // 4. Cria usuário
    // ----------------------------
    final result = await authenticationModule.createUserWithEmailAndPassword(
      email,
      password,
    );

    // Para loading
    setState(() => loading = false);

    // ----------------------------
    // 5. Se erro, mostrar mensagem
    // ----------------------------
    if (result != null) {
      // result geralmente contém o código do erro (ex: email já usado)
      setState(() {
        emailError = "Email already in use or invalid";
        passwordError = "Check your password";
      });
      return;
    }

    // ----------------------------
    // 6. Sucesso → redireciona
    // ----------------------------
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, '/home');
  }

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
            errorText: nameError,
          ),
          const SizedBox(height: 16),

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
              : PrimaryButton(text: "Sign Up", onPressed: onRegisterPressed),

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
