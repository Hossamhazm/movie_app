import 'package:flutter/material.dart';
import 'package:movie_app/view/widgets/movie_item_in_search.dart';
import 'package:movie_app/viewModel/search_screen_view_model.dart';
import 'package:provider/provider.dart';

import '../../models/utilities/color_utility.dart';

class MovieSearchDelegate extends SearchDelegate {

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        toolbarTextStyle: const TextStyle(
          color: Colors.white
        ),
        titleTextStyle: const TextStyle(
          color: Colors.white
        ),
        backgroundColor: AppColors.secondaryColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider<SearchScreenViewModel>(
      create: (context) => SearchScreenViewModel(query: query),
      child: Container(
          color: AppColors.primaryColor,
          child: MovieItems(width: width, height: height)),
    ); //items here
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider<SearchScreenViewModel>(
      create: (context) => SearchScreenViewModel(query: query),
      child: Container(
          color: AppColors.primaryColor,
          child: MovieItems(width: width, height: height)),
    );
  }
}