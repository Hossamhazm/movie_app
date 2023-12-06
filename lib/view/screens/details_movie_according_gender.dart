import 'package:flutter/material.dart';
import 'package:movie_app/models/utilities/color_utility.dart';

import '../widgets/movie_item_in_browse.dart';

class DetailsMovieAccordingGender extends StatelessWidget {
  const DetailsMovieAccordingGender({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as Map;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        title: Text("${args['filmGener']} List"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: MovieItemsAccordingGener(width: width, height: height, id: args['id'],),
    );
  }
}
