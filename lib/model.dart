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

class Posters {
  final int id;
  final List<PostersResult> posters;

  Posters({required this.id, required this.posters});

  factory Posters.fromJson(Map<String, dynamic> json) {
    List<PostersResult> posterList;
    final data = json['posters'].map((i) => PostersResult.fromJson(i)).toList();
    posterList = List<PostersResult>.from(data);

    return Posters(
      id: json['id'] as int,
      posters: posterList,
    );
  }
}

class PostersResult {
  final double aspectRatio;
  final int height;
  final String filePath;
  final double voteAverage;
  final int voteCount;
  final int width;

  PostersResult(
      {required this.aspectRatio,
      required this.height,
      required this.filePath,
      required this.voteAverage,
      required this.voteCount,
      required this.width});

  factory PostersResult.fromJson(Map<String, dynamic> json) {
    return PostersResult(
      aspectRatio: json['aspect_ratio'] as double,
      height: json['height'] as int,
      filePath: json['file_path'] as String,
      voteAverage: json['vote_average'] as double,
      voteCount: json['vote_count'] as int,
      width: json['width'] as int,
    );
  }
}
