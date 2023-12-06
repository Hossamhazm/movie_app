import 'package:flutter/material.dart';
import 'package:movie_app/models/responses/TopRatedRepositries.dart';
import 'package:movie_app/view/widgets/custom_paint.dart';
import 'package:movie_app/viewModel/home_screen_view_model.dart';
import 'package:provider/provider.dart';

import '../../models/responses/PopularReposotries.dart';
import '../../models/utilities/color_utility.dart';
import '../../viewModel/details_screen_view_model.dart';
import '../../viewModel/favourite_view_model.dart';
import '../screens/details_screen.dart';

class TopRatedSection extends StatelessWidget {
  double height;
  double width;
  TopRatedSection({Key? key, required this.width, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    MovieViewModel movieViewModel = Provider.of(context);

    return movieViewModel.isLoading3
        ? const Center(
      child: CircularProgressIndicator(),
    )
        : movieViewModel.error3.isNotEmpty
        ? Center(
      child: Text(
        movieViewModel.error3,
        style: const TextStyle(
            fontSize: 16.0, fontWeight: FontWeight.bold),
      ),
    )
        : Container(
      color: AppColors.secondaryColor,
      width: width,
      child: Column(
        children: [
          Container(
            width: width,
            padding: const EdgeInsets.all(8),
            child: const Text(
              "Recommended",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 288, // Provide a fixed height to the container
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movieViewModel.topRatedTV.length,
              itemBuilder: (context, index) {
                TopRatedMovies? topRatedMovies = movieViewModel.topRatedTV.isNotEmpty ? movieViewModel.topRatedTV[index] : null;
                return Container(
                  width: 150,
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: AppColors.secondaryColor,
                    elevation: 10,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              GestureDetector(
                                onTap:(){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ChangeNotifierProvider<DetailsScreenViewModel>(
                                        create: (context) => DetailsScreenViewModel(id: topRatedMovies.id.toString()),
                                        child: const DetailsScreen(),
                                      ),
                                      settings: RouteSettings(
                                        arguments: {
                                          'filmName': topRatedMovies.title ?? "no name",
                                          'posterPath': topRatedMovies.posterPath ?? "image.1316918305.1116/st,small,845x845-pad,1000x1000,f8f8f8.jpg",
                                          'backDropPath': topRatedMovies.backdropPath ?? "image.1316918305.1116/st,small,845x845-pad,1000x1000,f8f8f8.jpg",
                                          'vote': topRatedMovies.voteAverage?.toString() ?? "no vote",
                                          'overview': topRatedMovies.overview ?? "null",
                                          'date': topRatedMovies.releaseDate ?? "no date",
                                        },
                                      ),
                                    ),
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius:BorderRadius.circular(7),
                                  child: SizedBox(
                                    child: Image.network(
                                      'https://image.tmdb.org/t/p/w200/${topRatedMovies!.posterPath ?? "image.1316918305.1116/st,small,845x845-pad,1000x1000,f8f8f8.jpg"}',
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
                                  ),
                                ),
                              ),
                              Consumer<FavoriteProvider>(
                                builder: (context, favoriteProvider, _) {
                                  return BuildCustomPaint(movie: topRatedMovies,);
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 3),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 15,
                                  color: AppColors.selectedIconsColor,
                                ),
                                const SizedBox(width: 5),
                                 Text(
                                  topRatedMovies.voteAverage?.toString() ?? "without rate",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 3),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              topRatedMovies.title ?? "without name",
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              topRatedMovies.releaseDate ?? "without date",
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
