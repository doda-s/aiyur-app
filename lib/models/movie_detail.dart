class MovieDetail {
  final int movieId;
  final String title;
  final String description;
  final String imageUrl;
  final double voteAverage;
  final List<dynamic> genreIds;
  final String releaseDate;
  final int? duration; // opcional pois a API às vezes retorna null

  MovieDetail({
    required this.movieId,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.voteAverage,
    required this.genreIds,
    required this.releaseDate,
    this.duration,
  });

  // Factory para converter JSON do TMDB em MovieDetail
  factory MovieDetail.fromJson(Map<dynamic, dynamic> json) {
    return MovieDetail(
      movieId: json['id'],
      title: json['title'] ?? '',
      description: json['overview'] ?? '',
      imageUrl: json['poster_path'] ?? '',
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      genreIds: json['genres'] != null
          ? List<int>.from(json['genres'].map((g) => g['id']))
          : (json['genre_ids'] != null
                ? List<int>.from(json['genre_ids'])
                : []),
      releaseDate: json['release_date'] ?? '',
      duration: json['runtime'], // pode vir null
    );
  }
}

class MovieList {
  final List<int> movieIds;
  final String title;
  final String description;

  MovieList({
    required this.movieIds,
    required this.title,
    required this.description,
  });
}
