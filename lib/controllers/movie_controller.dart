import 'dart:core';

import 'package:aiyurapp/main.dart';
import 'package:aiyurapp/models/movie_detail.dart';

class MovieController {
  static final MovieController _instance = MovieController._internal();
  factory MovieController() => _instance;
  MovieController._internal();

  Future<List<dynamic>> getMovieGenreList() async {
    dynamic result = await cacheService.load("movie_genre_list");

    if (result == null || result is! List || result.isEmpty) {
      result = await tmdb.getMovieGenres();
      cacheService.save("movie_genre_list", result, ttl: Duration(hours: 24));
    }

    return List<dynamic>.from(result);
  }

  Future<MovieDetail> getMovieById(int movieId) async {
    final result = await tmdb.getMovieById(movieId);
    return MovieDetail.fromJson(result);
  }

  Future<List<MovieDetail>> searchMovies(String query) async {
    final result = await tmdb.searchMovies(query);

    final moviesJson = result['results'] as List<dynamic>;

    return moviesJson.map((json) => MovieDetail.fromJson(json)).toList();
  }
}
