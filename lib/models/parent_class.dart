class Movie {
  String? backdropPath;
  List<num>? genreIds;
  num? id;
  String? originalLanguage;
  String? overview;
  num? popularity;
  String? posterPath;
  num? voteAverage;
  num? voteCount;
  String? title;
  String? releaseDate;
  String? originalName;

  Movie({
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.overview,
    this.popularity,
    this.posterPath,
    this.voteAverage,
    this.voteCount,
    this.title,
    this.releaseDate,
    this.originalName,
  });

  Movie.fromJson(dynamic json) {
    backdropPath = json['backdrop_path'];
    genreIds = json['genre_ids'] != null ? List<num>.from(json['genre_ids']) : [];
    id = json['id'];
    originalLanguage = json['original_language'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    title = json['name'];
    releaseDate = json['first_air_date'];
    originalName = json['original_name'];
  }

}