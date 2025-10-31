import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const ProfileButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: CircleAvatar(
        radius: 20, // tamanho menor do perfil
        backgroundImage: const NetworkImage(
          "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg",
        ),
      ),
    );
  }
}
