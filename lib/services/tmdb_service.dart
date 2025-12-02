import 'package:tmdb_api/tmdb_api.dart';

class TmdbService {
  static final TmdbService _instance = TmdbService._internal();

  factory TmdbService() {
    return _instance;
  }

  TmdbService._internal();

  late TMDB _tmdb;

  bool _initialized = false;

  Future<void> initialize({
    required String apiKey,
    required String readAccessToken,
    bool enableLogs = false,
  }) async {
    if (_initialized) return;

    _tmdb = TMDB(
      ApiKeys(apiKey, readAccessToken),
      logConfig: enableLogs
          ? const ConfigLogger(showLogs: true, showErrorLogs: true)
          : const ConfigLogger(showLogs: false),
    );

    _initialized = true;
  }

  Future<List<dynamic>> getMovieGenres() async {
    final response = await _tmdb.v3.genres.getMovieList();
    return response["genres"] ?? [];
  }

  Future<Map<dynamic, dynamic>> getPopular({int page = 1}) async {
    return await _tmdb.v3.movies.getPopular(page: page);
  }

  Future<Map<dynamic, dynamic>> getNowPlaying({int page = 1}) async {
    return await _tmdb.v3.movies.getNowPlaying(page: page);
  }

  Future<Map<dynamic, dynamic>> getTopRated({int page = 1}) async {
    return await _tmdb.v3.movies.getTopRated(page: page);
  }

  Future<Map<dynamic, dynamic>> discoverMovies({int page = 1}) async {
    return await _tmdb.v3.discover.getMovies(page: page);
  }

  Future<Map<dynamic, dynamic>> searchMovies(
    String query, {
    int page = 1,
  }) async {
    return await _tmdb.v3.search.queryMovies(query, page: page);
  }

  Future<Map<dynamic, dynamic>> getMovieById(int id) async {
    return await _tmdb.v3.movies.getDetails(id);
  }
}
