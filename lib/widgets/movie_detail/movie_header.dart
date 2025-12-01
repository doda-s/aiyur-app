import 'package:flutter/material.dart';

class MovieHeader extends StatelessWidget {
  final String imageUrl;

  const MovieHeader({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 300,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 300,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.7),
                Colors.black.withOpacity(0.2),
                Colors.transparent,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
      ],
    );
  }
}
