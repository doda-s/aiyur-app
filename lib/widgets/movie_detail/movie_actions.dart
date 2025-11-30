import 'package:flutter/material.dart';

class MovieActions extends StatelessWidget {
  final VoidCallback onFavorite;
  final VoidCallback onAddToList;

  const MovieActions({
    super.key,
    required this.onFavorite,
    required this.onAddToList,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onFavorite,
            child: const Icon(Icons.favorite_border, color: Color(0xFF4A4A4A)),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton(
            onPressed: onAddToList,
            child: const Icon(Icons.bookmark_border, color: Color(0xFF4A4A4A)),
          ),
        ),
      ],
    );
  }
}
