import 'package:flutter/material.dart';

import '../models/data/api_mangement.dart';
import '../models/responses/MoviesCategoriesResponses.dart';

class BrowseScreenViewModel extends ChangeNotifier {
  String _error = '';
  bool _isLoading = false;
  MoviesCategoriesResponses? moviesCategoriesResponses;

  String get error => _error;
  bool get isLoading => _isLoading;

  BrowseScreenViewModel() {
    fetchGenerData();
  }

  Future<MoviesCategoriesResponses?> fetchGenerData() async {
    _isLoading = true;
    notifyListeners();

    try {
      moviesCategoriesResponses = await MovieService.getGeners();
      _error = '';
      return moviesCategoriesResponses;
    } catch (error) {
      moviesCategoriesResponses = null;
      _error = 'Failed to fetch Similar Movies';
      return moviesCategoriesResponses;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}