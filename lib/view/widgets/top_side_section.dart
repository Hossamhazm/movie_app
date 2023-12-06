import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/responses/PopularReposotries.dart';
import 'package:movie_app/view/screens/details_screen.dart';
import 'package:movie_app/view/widgets/custom_paint.dart';
import 'package:movie_app/viewModel/home_screen_view_model.dart';
import 'package:provider/provider.dart';

import '../../viewModel/details_screen_view_model.dart';
import '../../viewModel/favourite_view_model.dart';

class TopSideSection extends StatelessWidget {
  double height;
  double width;
  TopSideSection({Key? key, required this.height, required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    MovieViewModel movieViewModel = Provider.of<MovieViewModel>(context);
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
            : CarouselSlider.builder(
                itemCount: movieViewModel.movies.length,
                itemBuilder: (context, index, _) {
                  Movies? movies = movieViewModel.movies.isNotEmpty
                      ? movieViewModel.movies[index]
                      : null;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: height * 0.36,
                      child: Stack(
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                Image.network(
                                  height: height * 0.25,
                                  'https://image.tmdb.org/t/p/w200/${movies!.backdropPath ?? "image.1316918305.1116/st,small,845x845-pad,1000x1000,f8f8f8.jpg"}',
                                  fit: BoxFit.cover,
                                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                    return const Center(child: Text('Image not found!',
                                      style: TextStyle(
                                          color: Colors.white
                                      ),
                                    ),
                                    );
                                  },
                                ),
                                SizedBox(
                                  width: width,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 140, top: 10, bottom: 10),
                                    child: Text(
                                      movies.title ?? "null",
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: width,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 140),
                                    child: Text(
                                      movies.releaseDate ?? "",
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            left: 0,
                            bottom: 0,
                            child: SizedBox(
                              height: 199,
                              width: 129,
                              child: Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => ChangeNotifierProvider<DetailsScreenViewModel>(
                                            create: (context) => DetailsScreenViewModel(id: movies.id.toString()),
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
                                        'https://image.tmdb.org/t/p/w200/${movies.posterPath}',
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
                                  Consumer<FavoriteProvider>(
                                    builder: (context, favoriteProvider, _) {
                                      return BuildCustomPaint(movie: movies,);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  height: height * 0.36,
                  aspectRatio: 18 / 9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  scrollDirection: Axis.horizontal,
                ),
              );
  }
}
