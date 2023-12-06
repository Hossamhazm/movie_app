import 'package:flutter/cupertino.dart';
import 'package:movie_app/models/responses/LatestReposotries.dart';
import 'package:movie_app/models/responses/PopularReposotries.dart';
import 'package:movie_app/models/responses/TopRatedRepositries.dart';

import '../models/data/api_mangement.dart';

class MovieViewModel extends ChangeNotifier {
  List<Movies> _movies = [];
  List<TopRatedMovies> _topRatedTV = [];
  String _error = '';
  String _error2 = '';
  String _error3 = '';
  bool _isLoading = false;
  bool _isLoading2 = false;
  bool _isLoading3 = false;
  int _currentIndex = 0;
  LatestReposotries? latestMovie;


  List<Movies> get movies => _movies;
  List<dynamic> get topRatedTV => _topRatedTV;
  String get error => _error;
  String get error2 => _error2;
  String get error3 => _error3;
  bool get isLoading => _isLoading;
  bool get isLoading2 => _isLoading2;
  bool get isLoading3 => _isLoading3;
  int get currentIndex => _currentIndex;

  MovieViewModel(){
    fetchTopRatedTV();
    fetchPopularMovies();
    fetchLatestMovie();
  }

  void tabsToggle(int value){
    _currentIndex = value;
    notifyListeners();
  }

  Future<void> fetchPopularMovies() async {
    _isLoading = true;
    notifyListeners();

    try {
      List<Movies> popularMovies = await MovieService.getPopularMovies();
      _movies = popularMovies;
      _error = '';
    } catch (e) {
      _movies = [];
      _error = 'Failed to fetch popular movies: $e';
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }



  Future<void> fetchLatestMovie() async {
    _isLoading2 = true;
    notifyListeners();

    try {
      LatestReposotries movieData = await MovieService.getLatestMovie();
      latestMovie = movieData;
      _error2 ='';
    } catch (error) {
      latestMovie =null;
      _error2 = 'Failed to fetch latest movies: $error';
    } finally {
      _isLoading2 = false;
      notifyListeners();
    }
  }


  Future<void> fetchTopRatedTV() async {
    _isLoading3 = true;
    notifyListeners();

    try {
      List<TopRatedMovies> topRatedFromApi = await MovieService.getTopRatedTV();
      _topRatedTV = topRatedFromApi;
      _error3 = '';
    } catch (e) {
      _topRatedTV = [];
      _error3 = 'Failed to fetch popular movies: $e';
    } finally {
      _isLoading3 = false;
      notifyListeners();
    }
  }


}