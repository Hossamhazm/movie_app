class MoviesCategoriesResponses {
  MoviesCategoriesResponses({
      List<Genres>? genres,}){
    _genres = genres;
}

  MoviesCategoriesResponses.fromJson(dynamic json) {
    if (json['genres'] != null) {
      _genres = [];
      json['genres'].forEach((v) {
        _genres?.add(Genres.fromJson(v));
      });
    }
  }
  List<Genres>? _genres;
MoviesCategoriesResponses copyWith({  List<Genres>? genres,
}) => MoviesCategoriesResponses(  genres: genres ?? _genres,
);
  List<Genres>? get genres => _genres;
}

class Genres {
  Genres({
      num? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  Genres.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  num? _id;
  String? _name;
Genres copyWith({  num? id,
  String? name,
}) => Genres(  id: id ?? _id,
  name: name ?? _name,
);
  num? get id => _id;
  String? get name => _name;

}