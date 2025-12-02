import 'package:aiyurapp/widgets/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:aiyurapp/services/movie_service.dart';

class MovieInfoSection extends StatefulWidget {
  final String? title;
  final double? voteAverage;
  final int? movieId;
  final String? releaseDate;

  const MovieInfoSection({
    super.key,
    this.title,
    this.movieId,
    this.voteAverage,
    this.releaseDate,
  });

  @override
  State<MovieInfoSection> createState() => _MovieInfoSectionState();
}

class _MovieInfoSectionState extends State<MovieInfoSection> {
  int? runtime;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadMovieDetails();
  }

  Future<void> loadMovieDetails() async {
    try {
      if (widget.movieId == null) {
        setState(() => loading = false);
        return;
      }

      final movie = await tmdb.getMovieById(widget.movieId!);

      setState(() {
        runtime = movie["runtime"];
        loading = false;
      });
    } catch (e) {
      print("Erro ao buscar duração: $e");
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Se voteAverage for nulo → "--%"
    final formattedVote = widget.voteAverage != null
        ? "${(widget.voteAverage! * 10).toStringAsFixed(0)}%"
        : "--%";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title ?? "Sem título",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text("⭐ $formattedVote"),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        Row(
          children: [
            const Icon(Icons.calendar_today, size: 18),
            const SizedBox(width: 8),
            Text(widget.releaseDate ?? "--"),
            const SizedBox(width: 20),

            const Icon(Icons.access_time, size: 18),
            const SizedBox(width: 8),
            loading
                ? const Text("...")
                : Text(runtime != null ? "$runtime min" : "--"),
          ],
        ),
      ],
    );
  }
}
