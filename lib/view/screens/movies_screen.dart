import 'package:flutter/material.dart';
import 'package:movie_app/view/widgets/new_release_section.dart';
import 'package:movie_app/view/widgets/top_rated_section.dart';
import 'package:movie_app/view/widgets/top_side_section.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SizedBox(
      height: height,
      width: width,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TopSideSection(height: height, width: width),
              const SizedBox(height: 20,),
              NewReleaseSection(width: width, height: height),
              const SizedBox(height: 20,),
              TopRatedSection(width: width, height: height),
            ],
          ),
        ),
      ),
    );
  }
}



/*Image.network(
              'https://image.tmdb.org/t/p/w200/${movie.posterPath}',
            ),*/


/*Center(
        child: Text(
          movieViewModel.error,
          style:
          const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
      )*/