import 'package:flutter/material.dart';
import 'package:movie_app/models/parent_class.dart';
import 'package:provider/provider.dart';

import '../../viewModel/favourite_view_model.dart';
import '../widgets/custom_paint.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FavoriteProvider favoriteProvider = Provider.of<FavoriteProvider>(context);
    List<Movie> favorites = favoriteProvider.favorites;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Column(
        children: [
          Container(
            width: width,
            padding: const EdgeInsets.all(20.0),
            child: const Text(
              "Watchlist",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (BuildContext context, int index) {
                  Movie? movies = favoriteProvider.favorites.isNotEmpty
                      ? favoriteProvider.favorites[index]
                      : null;
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    height: height / 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          height : 120,
                                          width : 170,
                                          'https://image.tmdb.org/t/p/w200/${favorites[index].posterPath ?? "image.1316918305.1116/st,small,845x845-pad,1000x1000,f8f8f8.jpg"}',
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
                                      Consumer<FavoriteProvider>(
                                        builder: (context, favoriteProvider, _) {
                                          return BuildCustomPaint(movie: movies!,);
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                                        child: Text(
                                          favorites[index].title ?? "no name",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 19,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 7.0),
                                        child: Text(
                                          favorites[index].releaseDate ?? "no date",
                                          style: const TextStyle(
                                            color: Colors.white70,//70
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Popularity: ${favorites[index]?.popularity.toString() ??"no popularity founded"}",
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          height: 1,
                          width: width,
                          color: Colors.grey,
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