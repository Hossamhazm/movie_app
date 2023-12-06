import 'package:flutter/foundation.dart';
import '../models/parent_class.dart';

class FavoriteProvider extends ChangeNotifier {
  List<Movie> favorites = [];
  bool isPressed = false;


  void togglePressed(){
    isPressed = !isPressed;
    notifyListeners();
  }
  void addToFavorites(Movie movie) {
    favorites.add(movie);
    notifyListeners();
  }

  void removeFromFavorites(Movie movie) {
    favorites.remove(movie);
    notifyListeners();
  }

  bool isFavorite(Movie movie) {
    return favorites.contains(movie);
  }
}