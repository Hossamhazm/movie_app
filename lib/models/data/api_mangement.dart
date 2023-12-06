import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/responses/LatestReposotries.dart';
import 'package:movie_app/models/responses/TopRatedRepositries.dart';

import '../responses/MoviesCategoriesResponses.dart';
import '../responses/MoviesGenerDetailsResponses.dart';
import '../responses/PopularReposotries.dart';
import '../responses/SearchResponces.dart';
import '../responses/SimilarResponses.dart';


class MovieService {

  static const String _baseUrl = 'https://api.themoviedb.org/3';
  static const String _apiKey = '128e69a5e2a57e94653b738e708ec184'; // Replace with your API key

  static Future<List<Movies>> getPopularMovies() async {
    const apiKey = '128e69a5e2a57e94653b738e708ec184'; //add e
    const url = 'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print("Doooooooooooooone");
      final jsonData = json.decode(response.body);
      List<Movies> movies = [];

      for (var item in jsonData['results']) {
        movies.add(Movies.fromJson(item));
      }

      return movies;
    } else {
      throw Exception('Failed to load popular movies: ${response.statusCode}');
    }
  }

  static Future<LatestReposotries> getLatestMovie() async {
    const url = '$_baseUrl/movie/latest?api_key=$_apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      LatestReposotries latestReposotries = LatestReposotries.fromJson(jsonData);

      return latestReposotries;
    } else {
      throw Exception('Failed to fetch latest repositories');
    }
  }

  static Future<List<TopRatedMovies>> getTopRatedTV() async {
    const url =
        '$_baseUrl/tv/top_rated?api_key=$_apiKey&language=en-US&page=1&results=results';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      List<TopRatedMovies> movies = (jsonData['results'] as List)
          .map((item) => TopRatedMovies.fromJson(item))
          .toList();

      return movies;
    } else {
      throw Exception('Failed to fetch popular movies');
    }
  }

  static Future<SimilarResponses> getSimilarMovies(String id) async{
    String url = '$_baseUrl/movie/678512/similar?language=en-US&page=1&movie_id=$id&api_key=$_apiKey';
    final responses =await http.get(Uri.parse(url));
    if(responses.statusCode == 200 ){
      final jsonData = json.decode(responses.body);
      return SimilarResponses.fromJson(jsonData);
    } else {
      throw Exception('Failed to load similar movies : ${responses.statusCode}');
    }
  }

  static Future<SearchResponces> getSearchedMovies(String query) async{
    String url = '$_baseUrl/search/movie?query=$query&include_adult=false&language=en-US&page=1&api_key=$_apiKey';
    final responses =await http.get(Uri.parse(url));
    if(responses.statusCode == 200 ){
      print("MONMOM DONE");
      final jsonData = json.decode(responses.body);
      return SearchResponces.fromJson(jsonData);
    } else {
      throw Exception('Failed to load searched movies : ${responses.statusCode}');
    }
  }

  static Future<MoviesCategoriesResponses> getGeners() async{
    String url = '$_baseUrl/genre/movie/list?language=en&api_key=$_apiKey';
    final responses =await http.get(Uri.parse(url));
    if(responses.statusCode == 200 ){
      final jsonData = json.decode(responses.body);
      return MoviesCategoriesResponses.fromJson(jsonData);
    } else {
      throw Exception('Failed to load geners : ${responses.statusCode}');
    }
  }

  static Future<List<MoviesGener>> getMoviesGener() async {
    const url =
        '$_baseUrl/discover/movie?sort_by=popularity.desc&api_key=$_apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      List<MoviesGener> moviesGener = (jsonData['results'] as List)
          .map((item) => MoviesGener.fromJson(item))
          .toList();

      return moviesGener;
    } else {
      throw Exception('Failed to fetch movies according to gener movies');
    }
  }
}