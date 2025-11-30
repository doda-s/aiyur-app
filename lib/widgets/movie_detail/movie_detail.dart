import 'package:aiyurapp/models/movie_detail.dart';
import 'package:aiyurapp/widgets/movie_detail/moive_header.dart';
import 'package:aiyurapp/widgets/movie_detail/movie_actions.dart';
import 'package:aiyurapp/widgets/movie_detail/movie_genres.dart';
import 'package:aiyurapp/widgets/movie_detail/movie_info_section.dart';
import 'package:aiyurapp/widgets/movie_detail/movie_list_popup.dart';
import 'package:aiyurapp/widgets/movie_detail/movie_synopsis.dart';
import 'package:flutter/material.dart';

class MovieDetailPage extends StatefulWidget {
  final String title;
  final String imageUrl;

  const MovieDetailPage({
    super.key,
    required this.title,
    required this.imageUrl,
  });

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  // Agora com model
  final List<MovieDetail> _userLists = [
    MovieDetail(
      title: "Favorites",
      description: "My all-time favorite movies",
      imageUrl: '',
    ),
    MovieDetail(
      title: "Watch Later",
      description: "Movies I want to see soon",
      imageUrl: '',
    ),
    MovieDetail(
      title: "Sci-Fi Collection",
      description: "Best futuristic titles",
      imageUrl: '',
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
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MovieHeader(
              imageUrl: "https://image.tmdb.org/t/p/w500" + widget.imageUrl,
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
                  MovieInfoSection(title: widget.title),
                  const SizedBox(height: 24),

                  MovieActions(
                    onFavorite: () => debugPrint("Favoritou"),
                    onAddToList: _openListPopup,
                  ),

                  const SizedBox(height: 24),
                  const MovieGenres(),
                  const SizedBox(height: 24),
                  const MovieSynopsis(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
