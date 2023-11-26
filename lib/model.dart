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

class CastResult {
  final int id;
  final List<Casts> cast;
  final List<Crews> crew;

  CastResult({required this.id, required this.cast, required this.crew});

  factory CastResult.fromJson(Map<String, dynamic> json) {
    List<Casts> castList;
    // TODO: 필요한 갯수만 take하고 끝내기
    final castData = json['cast'].map((i) => Casts.fromJson(i)).toList();
    castList = List<Casts>.from(castData).sublist(0, 5);

    List<Crews> crewList;
    final crewData = json['crew'].map((i) => Crews.fromJson(i)).toList();
    crewList = List<Crews>.from(crewData)
        .where((element) => element.job == 'Director')
        .toList();

    return CastResult(
      id: json['id'] as int,
      cast: castList,
      crew: crewList,
    );
  }
}

class Casts {
  final int id;
  final String originalName;
  final double popularity;

  Casts(
      {required this.id, required this.originalName, required this.popularity});

  factory Casts.fromJson(Map<String, dynamic> json) {
    return Casts(
      id: json['id'] as int,
      originalName: json['original_name'] as String,
      popularity: json['popularity'] as double,
    );
  }
}

class Crews {
  final int id;
  final String originalName;
  final double popularity;
  final String job;

  Crews(
      {required this.id,
      required this.originalName,
      required this.popularity,
      required this.job});

  factory Crews.fromJson(Map<String, dynamic> json) {
    return Crews(
      id: json['id'] as int,
      originalName: json['original_name'] as String,
      popularity: json['popularity'] as double,
      job: json['job'] as String,
    );
  }
}

class MyCollectionResult {
  final List<MyCollection> myCollections;

  MyCollectionResult({required this.myCollections});

  factory MyCollectionResult.fromJson(Map<String, dynamic> json) {
    final data =
        json['collections'].map((i) => MyCollection.fromJson(i)).toList();
    List<MyCollection> myCollectionList = List<MyCollection>.from(data);

    return MyCollectionResult(
      myCollections: myCollectionList,
    );
  }
}

class MyCollection {
  final String id;
  final String imageUrl;

  MyCollection({
    required this.id,
    required this.imageUrl,
  });

  factory MyCollection.fromJson(Map<String, dynamic> json) {
    return MyCollection(
      id: json['id'] as String,
      imageUrl: json['image_url'] as String,
    );
  }
}

class CollectionDetail {
  final String id;
  final String authorId;
  final int movieId;
  final String movieTitle;
  // final List<Genre> genre;
  final double rating;
  final String content;
  final bool isPost;
  final int meToo;
  final DateTime? watchedAt;

  CollectionDetail({
    required this.id,
    required this.authorId,
    required this.movieId,
    required this.movieTitle,
    // required this.genre,
    required this.rating,
    required this.content,
    required this.isPost,
    required this.meToo,
    this.watchedAt,
  });

  factory CollectionDetail.fromJson(Map<String, dynamic> json) {
    // List<Genre> genreList;
    // final data = json['genre'].map((i) => Genre.fromJson(i)).toList();
    // genreList = List<Genre>.from(data);

    return CollectionDetail(
      id: json['id'] as String,
      authorId: json['author_id'] as String,
      movieId: json['movie_id'] as int,
      movieTitle: json['movie_title'] as String,
      // genre: genreList,
      rating: json['rating'] as double,
      content: json['content'] as String,
      isPost: json['is_post'] as bool,
      meToo: json['me_too'] as int,
      watchedAt: json['watched_at'] != null
          ? DateTime.parse(json['watched_at'])
          : null,
    );
  }
}
