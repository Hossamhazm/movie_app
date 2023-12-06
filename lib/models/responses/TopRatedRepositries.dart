import 'package:movie_app/models/parent_class.dart';

class TopRatedRepositries {
  TopRatedRepositries({
      num? page, 
      List<TopRatedMovies>? results,
      num? totalPages, 
      num? totalResults,}){
    _page = page;
    _results = results;
    _totalPages = totalPages;
    _totalResults = totalResults;
}

  TopRatedRepositries.fromJson(dynamic json) {
    _page = json['page'];
    if (json['results'] != null) {
      _results = [];
      json['results'].forEach((v) {
        _results?.add(TopRatedMovies.fromJson(v));
      });
    }
    _totalPages = json['total_pages'];
    _totalResults = json['total_results'];
  }
  num? _page;
  List<TopRatedMovies>? _results;
  num? _totalPages;
  num? _totalResults;
TopRatedRepositries copyWith({  num? page,
  List<TopRatedMovies>? results,
  num? totalPages,
  num? totalResults,
}) => TopRatedRepositries(  page: page ?? _page,
  results: results ?? _results,
  totalPages: totalPages ?? _totalPages,
  totalResults: totalResults ?? _totalResults,
);
  num? get page => _page;
  List<TopRatedMovies>? get results => _results;
  num? get totalPages => _totalPages;
  num? get totalResults => _totalResults;
}

class TopRatedMovies extends Movie {
  List<String>? originCountry;

  TopRatedMovies({
    this.originCountry,
    String? backdropPath,
    List<num>? genreIds,
    num? id,
    String? originalLanguage,
    String? overview,
    num? popularity,
    String? posterPath,
    num? voteAverage,
    num? voteCount,
    String? title, // Added title property
  }) : super(
    backdropPath: backdropPath,
    genreIds: genreIds,
    id: id,
    originalLanguage: originalLanguage,
    overview: overview,
    popularity: popularity,
    posterPath: posterPath,
    voteAverage: voteAverage,
    voteCount: voteCount,
    title: title, // Pass title to the Movie super class
  );

  TopRatedMovies.fromJson(dynamic json) : super.fromJson(json) {
    originCountry = json['origin_country'] != null ? List<String>.from(json['origin_country']) : [];
  }
}