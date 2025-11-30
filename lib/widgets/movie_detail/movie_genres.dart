import 'package:flutter/material.dart';

class MovieGenres extends StatelessWidget {
  const MovieGenres({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "Genres",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            Chip(label: Text("Sci-Fi")),
            Chip(label: Text("Thriller")),
          ],
        ),
      ],
    );
  }
}
