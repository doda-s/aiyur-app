import 'package:aiyurapp/main.dart';
import 'package:aiyurapp/models/movie_detail.dart';
import 'package:aiyurapp/services/movie_service.dart';
import 'package:aiyurapp/widgets/movie_detail/movie_header.dart';
import 'package:aiyurapp/widgets/movie_detail/movie_actions.dart';
import 'package:aiyurapp/widgets/movie_detail/movie_genres.dart';
import 'package:aiyurapp/widgets/movie_detail/movie_info_section.dart';
import 'package:aiyurapp/widgets/movie_detail/movie_list_popup.dart';
import 'package:aiyurapp/widgets/movie_detail/movie_synopsis.dart';
import 'package:flutter/material.dart';

class MovieDetailPage extends StatefulWidget {
  final int movieId;

  const MovieDetailPage({super.key, required this.movieId});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  MovieDetail? movie;
  bool loading = true;

  Future<MovieDetail> loadMovie() async {
    return await movieController.getMovieById(widget.movieId);
  }

  @override
  void initState() {
    super.initState();
    fetchMovie();
  }

  Future<void> fetchMovie() async {
    try {
      final result = await loadMovie();

      setState(() {
        movie = result;
        loading = false;
      });
    } catch (e) {
      print("Erro ao buscar o filme: $e");
      setState(() => loading = false);
    }
  }

  // Mock de listas do usuário
  final List<MovieList> _userLists = [
    MovieList(
      title: "Favorites",
      description: "My all-time favorite movies",
      movieIds: [],
    ),
    MovieList(
      title: "Watch Later",
      description: "Movies I want to see soon",
      movieIds: [],
    ),
    MovieList(
      title: "Sci-Fi Collection",
      description: "Best futuristic titles",
      movieIds: [],
    ),
  ];

  void _openListPopup() {
    MovieListPopup.showListSelection(
      context: context,
      lists: _userLists,
      onSelected: (selected) {
        MovieListPopup.showConfirm(context, selected.title);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (movie == null) {
      return const Scaffold(
        body: Center(child: Text("Erro ao carregar o filme.")),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(movie!.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MovieHeader(
              imageUrl: "https://image.tmdb.org/t/p/w500${movie!.imageUrl}",
            ),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MovieInfoSection(
                    title: movie!.title,
                    voteAverage: movie!.voteAverage,
                    movieId: movie!.movieId,
                    releaseDate: movie!.releaseDate,
                  ),

                  const SizedBox(height: 24),

                  MovieActions(
                    onFavorite: () => debugPrint("Favoritou"),
                    onAddToList: _openListPopup,
                  ),

                  const SizedBox(height: 24),
                  MovieGenres(genreIds: movie!.genreIds),
                  const SizedBox(height: 24),
                  MovieSynopsis(description: movie!.description),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
