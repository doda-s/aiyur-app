import 'package:aiyurapp/main.dart';
import 'package:flutter/material.dart';

class MovieGenres extends StatefulWidget {
  final List<dynamic> genreIds;
  const MovieGenres({super.key, required this.genreIds});

  @override
  State<MovieGenres> createState() => _MovieGenresState();
}

class _MovieGenresState extends State<MovieGenres> {
  List<Map<String, dynamic>> allGenres = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadGenres();
  }

  Future<void> loadGenres() async {
    try {
      final genres = await movieService.getMovieGenreList();

      setState(() {
        allGenres = List<Map<String, dynamic>>.from(genres);
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Text("Loading genres...");
    }

    final movieGenres = allGenres
        .where((g) => widget.genreIds.contains(g["id"]))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Genres",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: movieGenres.map((genre) {
            return Chip(label: Text(genre["name"]));
          }).toList(),
        ),
      ],
    );
  }
}
