class UserMovieList {
  final String title;
  final String description;
  final int movies;

  UserMovieList({
    required this.title,
    required this.description,
    required this.movies,
  });

  UserMovieList copyWith({String? title, String? description, int? movies}) {
    return UserMovieList(
      title: title ?? this.title,
      description: description ?? this.description,
      movies: movies ?? this.movies,
    );
  }
}
