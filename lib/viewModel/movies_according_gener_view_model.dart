import 'package:flutter/cupertino.dart';
import '../models/data/api_mangement.dart';
import '../models/responses/MoviesGenerDetailsResponses.dart';

class MovieAccordingGenerViewModel extends ChangeNotifier {
  String _error ='';
  bool _isLoading = false;
  List<MoviesGener> _moviesAccordingGender = [];


  List<MoviesGener> get moviersAccordingGener => _moviesAccordingGender;
  String get error => _error;
  bool get isLoading => _isLoading;

  MovieAccordingGenerViewModel(){
    fetchMovieAccordingGener();
  }


  Future<void> fetchMovieAccordingGener() async {
    _isLoading = true;
    notifyListeners();

    try {
      List<MoviesGener> topRatedFromApi = await MovieService.getMoviesGener();
      _moviesAccordingGender = topRatedFromApi;
      _error = '';
    } catch (e) {
      _moviesAccordingGender = [];
      _error = 'Failed to fetch popular movies: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


}