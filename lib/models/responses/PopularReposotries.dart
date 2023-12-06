import '../parent_class.dart';

class PopularReposotries {
  PopularReposotries({
      num? page, 
      List<Movies>? results,
      num? totalPages, 
      num? totalResults,}){
    _page = page;
    _results = results;
    _totalPages = totalPages;
    _totalResults = totalResults;
}

  PopularReposotries.fromJson(dynamic json) {
    _page = json['page'];
    if (json['results'] != null) {
      _results = [];
      json['results'].forEach((v) {
        _results?.add(Movies.fromJson(v));
      });
    }
    _totalPages = json['total_pages'];
    _totalResults = json['total_results'];
  }
  num? _page;
  List<Movies>? _results;
  num? _totalPages;
  num? _totalResults;
PopularReposotries copyWith({  num? page,
  List<Movies>? results,
  num? totalPages,
  num? totalResults,
}) => PopularReposotries(  page: page ?? _page,
  results: results ?? _results,
  totalPages: totalPages ?? _totalPages,
  totalResults: totalResults ?? _totalResults,
);
  num? get page => _page;
  List<Movies>? get results => _results;
  num? get totalPages => _totalPages;
  num? get totalResults => _totalResults;


}

class Movies extends Movie {
  bool? adult;
  String? originalTitle;
  @override
  String? releaseDate;
  @override
  String? title;
  bool? video;

  Movies({
    this.adult,
    this.originalTitle,
    this.releaseDate,
    this.title,
    this.video,
    String? backdropPath,
    List<num>? genreIds,
    num? id,
    String? originalLanguage,
    String? overview,
    num? popularity,
    String? posterPath,
    num? voteAverage,
    num? voteCount,
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
  );

  Movies.fromJson(dynamic json) : super.fromJson(json) {
    adult = json['adult'];
    originalTitle = json['original_title'];
    releaseDate = json['release_date'];
    title = json['title'];
    video = json['video'];
  }

}
