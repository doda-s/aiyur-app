import 'package:aiyurapp/services/cache.dart';
import 'package:flutter/material.dart';

final cache = CacheService();

class MovieGenres extends StatelessWidget {
  final List<int> genreIds;
  const MovieGenres({super.key, required this.genreIds});

  Future<void> loadGenres() async {
    try {
      final genres = await cache.load("genres");

      for (var genre in genres) {
        print(genre);
      }
    } catch (e) {
      print(e);
    }
  }

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
