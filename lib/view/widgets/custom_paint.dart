import 'package:flutter/material.dart';
import 'package:movie_app/models/parent_class.dart';
import 'package:provider/provider.dart';

import '../../viewModel/favourite_view_model.dart';

class BuildCustomPaint extends StatelessWidget {
  final Movie movie;

  const BuildCustomPaint({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FavoriteProvider favoriteProvider = Provider.of<FavoriteProvider>(context, listen: false);
    bool isFavorite = favoriteProvider.isFavorite(movie);

    return Stack(
      children: [
        isFavorite? Image.asset('assets/images/true_icon.png'):Image.asset('assets/images/false_icon.png'),
        Positioned(
          top:isFavorite? 1 :4,
          left: isFavorite? 9:7,
          child: GestureDetector(
            onTap: () {
              if (isFavorite) {
                favoriteProvider.removeFromFavorites(movie);
              } else {
                favoriteProvider.addToFavorites(movie);
              }
            },
            child: Text(
              isFavorite ? '-' : '+',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
      ],
    );
  }
}