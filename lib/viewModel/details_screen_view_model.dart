import 'package:flutter/material.dart';

import '../models/data/api_mangement.dart';
import '../models/responses/SimilarResponses.dart';

class DetailsScreenViewModel extends ChangeNotifier {
  String _error = '';
  String _id = '';
  bool _isLoading = false;
  SimilarResponses? similarResponses;

  String get error => _error;
  String get id => _id;
  bool get isLoading => _isLoading;

  DetailsScreenViewModel({required String id}) {
    _id = id;
    fetchSimilarData();
  }

  Future<SimilarResponses?> fetchSimilarData() async {
    _isLoading = true;
    notifyListeners();

    try {
      similarResponses = await MovieService.getSimilarMovies(_id);
      _error = '';
      return similarResponses;
    } catch (error) {
      similarResponses = null;
      _error = 'Failed to fetch Similar Movies';
      return similarResponses;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}