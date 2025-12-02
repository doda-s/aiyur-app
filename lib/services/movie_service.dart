import 'package:aiyurapp/main.dart';

class MovieService {
  static final MovieService _instance = MovieService._internal();
  factory MovieService() => _instance;
  MovieService._internal();

  Future<List<dynamic>> getMovieGenreList() async {
    dynamic result = await cacheService.load("movie_genre_list");

    if (result == null || result is! List || result.isEmpty) {
      result = await tmdb.getMovieGenres();
      cacheService.save("movie_genre_list", result, ttl: Duration(hours: 24));
    }

    return List<dynamic>.from(result);
  }
}
