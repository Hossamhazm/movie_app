import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/responses/MoviesGenerDetailsResponses.dart';
import '../../viewModel/movies_according_gener_view_model.dart';
class MovieItemsAccordingGener extends StatelessWidget {
  double height;
  double width;
  String id;
  MovieItemsAccordingGener({Key? key, required this.width, required this.height,required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MovieAccordingGenerViewModel movieAccordingGenerViewModel = Provider.of<MovieAccordingGenerViewModel>(context);

    List<MoviesGener> filteredMovies = movieAccordingGenerViewModel.moviersAccordingGener
        .where((movie) => movie.genreIds!.contains(num.parse(id)) == true)
        .toList();
    return movieAccordingGenerViewModel.isLoading
        ? const Center(
      child: CircularProgressIndicator(),
    )
        : movieAccordingGenerViewModel.error.isNotEmpty
        ? Center(
      child: Text(
        movieAccordingGenerViewModel.error,
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    )
        :ListView.builder(
      itemCount: filteredMovies?.length?? 0,
      itemBuilder: (BuildContext context, int index) {
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
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            height : 120,
                            width : 170,
                            'https://image.tmdb.org/t/p/w200/${filteredMovies[index].posterPath ?? "image.1316918305.1116/st,small,845x845-pad,1000x1000,f8f8f8.jpg"}',
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
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5.0),
                              child: Text(
                                filteredMovies[index]!.title ?? "no name",
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
                                filteredMovies[index]!?.releaseDate ?? "no date",
                                style: const TextStyle(
                                  color: Colors.white70,//70
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Text(
                              filteredMovies[index]!?.originalTitle ?? "no title founded",
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
    );
  }
}
