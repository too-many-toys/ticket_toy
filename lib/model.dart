class Movies {
  final int page;
  final List<MovieResults> results;
  final int totalPages;

  Movies({required this.page, required this.results, required this.totalPages});

  factory Movies.fromJson(Map<String, dynamic> json) {
    List<MovieResults> convertList;
    final data = json['results'].map((i) => MovieResults.fromJson(i)).toList();
    convertList = List<MovieResults>.from(data);

    return Movies(
      page: json['page'] as int,
      results: convertList,
      totalPages: json['total_pages'] as int,
    );
  }
}

class MovieResults {
  final int id;
  final String posterPath;
  final String title;
  final String releaseDate;
  final String originalTitle;
  final String originalLanguage;
  final String overview;
  final double voteAverage;
  final int voteCount;
  final double popularity;

  MovieResults(
      {required this.id,
      required this.posterPath,
      required this.title,
      required this.releaseDate,
      required this.originalTitle,
      required this.originalLanguage,
      required this.overview,
      required this.voteAverage,
      required this.voteCount,
      required this.popularity});

  factory MovieResults.fromJson(Map<String, dynamic> json) {
    return MovieResults(
      id: json['id'] as int,
      posterPath: json['poster_path'] as String,
      title: json['title'] as String,
      releaseDate: json['release_date'] as String,
      originalTitle: json['original_title'] as String,
      originalLanguage: json['original_language'] as String,
      overview: json['overview'] as String,
      voteAverage: json['vote_average'] as double,
      voteCount: json['vote_count'] as int,
      popularity: json['popularity'] as double,
    );
  }
}
