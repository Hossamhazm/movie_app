import 'dart:core';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/responses/PopularReposotries.dart';
import '../../models/utilities/color_utility.dart';
import '../../viewModel/details_screen_view_model.dart';
import '../../viewModel/favourite_view_model.dart';
import '../../viewModel/home_screen_view_model.dart';
import '../screens/details_screen.dart';
import 'custom_paint.dart';

class NewReleaseSection extends StatelessWidget {
  double width;
  double height;
  NewReleaseSection({Key? key, required this.width, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    MovieViewModel movieViewModel = Provider.of(context);

    return movieViewModel.isLoading
        ? const Center(
      child: CircularProgressIndicator(),
    )
        : movieViewModel.error.isNotEmpty
        ? Center(
      child: Text(
        movieViewModel.error,
        style: const TextStyle(
            fontSize: 16.0, fontWeight: FontWeight.bold),
      ),
    )
        : Container(
      color: AppColors.secondaryColor,
      height: 183,
      width: width,
      child: Column(
        children: [
          Container(
            width: width,
            padding: const EdgeInsets.all(8),
            child: const Text(
              "New Releases",
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          SizedBox(
            height: 135,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movieViewModel.movies.length,
              itemBuilder: (context, index) {
                Movies? movies = movieViewModel.movies.isNotEmpty
                    ? movieViewModel.movies[index]
                    : null;
                return Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Stack(
                    children: [
                      SizedBox(
                        width : 100,
                        height : 130,
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ChangeNotifierProvider<DetailsScreenViewModel>(
                                  create: (context) => DetailsScreenViewModel(id: movies!.id.toString()),
                                  child: const DetailsScreen(),
                                ),
                                settings: RouteSettings(
                                  arguments: {
                                    'filmName': movies.title ?? "no name",
                                    'posterPath': movies.posterPath ?? "image.1316918305.1116/st,small,845x845-pad,1000x1000,f8f8f8.jpg",
                                    'backDropPath': movies.backdropPath ?? "image.1316918305.1116/st,small,845x845-pad,1000x1000,f8f8f8.jpg",
                                    'vote': movies.voteAverage?.toString() ?? "no vote",
                                    'overview': movies.overview ?? "null",
                                    'date': movies.releaseDate ?? "no date",
                                  },
                                ),
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(7),
                            child: Image.network(
                              'https://image.tmdb.org/t/p/w200/${movies!.posterPath ?? "image.1316918305.1116/st,small,845x845-pad,1000x1000,f8f8f8.jpg"}',
                              fit: BoxFit.fill,
                              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                return const Center(child: Text('Image not found!',
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Consumer<FavoriteProvider>(
                        builder: (context, favoriteProvider, _) {
                          return BuildCustomPaint(movie: movies,);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}