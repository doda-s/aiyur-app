import 'package:flutter/material.dart';

class MovieSynopsis extends StatelessWidget {
  const MovieSynopsis({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "Synopsis",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(height: 8),
        Text(
          "In a dystopian future, a rogue hacker discovers a conspiracy that threatens the digital consciousness of humanity.",
          style: TextStyle(color: Colors.black87, height: 1.4),
        ),
      ],
    );
  }
}
