import 'package:flutter/material.dart';

class MovieSynopsis extends StatelessWidget {
  final String description;

  const MovieSynopsis({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Synopsis",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(height: 8),
        Text(description, style: TextStyle(color: Colors.black87, height: 1.4)),
      ],
    );
  }
}
