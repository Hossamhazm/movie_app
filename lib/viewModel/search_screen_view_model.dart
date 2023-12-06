import 'package:flutter/material.dart';

import '../models/data/api_mangement.dart';
import '../models/responses/SearchResponces.dart';

class SearchScreenViewModel extends ChangeNotifier{
  String _error = '';
  String _query = '';
  bool _isLoading = false;
  SearchResponces? searchResponses;

  String get error => _error;
  String get query => _query;
  bool get isLoading => _isLoading;

  SearchScreenViewModel({required String query}) {
    _query = query;
    fetchSearchedData();
  }

  Future<SearchResponces?> fetchSearchedData() async {
    _isLoading = true;
    notifyListeners();

    try {
      searchResponses = await MovieService.getSearchedMovies(_query);
      _error = '';
      return searchResponses;
    } catch (error) {
      searchResponses = null;
      _error = 'Failed to fetch Similar Movies';
      return searchResponses;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}