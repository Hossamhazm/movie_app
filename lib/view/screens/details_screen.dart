import 'package:flutter/material.dart';
import 'package:movie_app/models/responses/SimilarResponses.dart';
import 'package:movie_app/models/utilities/color_utility.dart';
import 'package:movie_app/viewModel/details_screen_view_model.dart';
import 'package:provider/provider.dart';

import '../../viewModel/favourite_view_model.dart';
import '../widgets/custom_paint.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var args = ModalRoute.of(context)!.settings.arguments as Map;

    DetailsScreenViewModel detailsScreenViewModel =Provider.of<DetailsScreenViewModel>(context);


    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
        title: Center(
          child: Text(args['filmName'],
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.white
          ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              height: height * 0.25,
              width: width,
              'https://image.tmdb.org/t/p/w200/${args['backDropPath'] ?? "image.1316918305.1116/st,small,845x845-pad,1000x1000,f8f8f8.jpg"}',
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
                    left: 15, top: 10, bottom: 10),
                child: Text(
                  args['filmName'] ,
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
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  args['date'],
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15,),
            SizedBox(
               width: width,
               child: Row(
                children: [
                  const SizedBox(width: 15),
                  SizedBox(
                    height: height * 0.25,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w200/${args['posterPath']}',
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
                        //const BuildCustomPaint(),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 40,
                          width: 60,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black45),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Center(
                            child: Text(
                              "Action",
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          args['overview'],
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                          style: const TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.star,
                              size: 20,
                              color: AppColors.selectedIconsColor,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              args['vote'],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ],
            ),
             ),
            const SizedBox(height: 20,),
            Container(
                child: detailsScreenViewModel.isLoading
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : detailsScreenViewModel.error.isNotEmpty
                    ? Center(
                  child: Text(
                    detailsScreenViewModel.error,
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
                          "More Like This",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 300, // Provide a fixed height to the container//////////////////////////////////
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: detailsScreenViewModel.similarResponses!.results!.length,
                          itemBuilder: (context, index) {
                            SimilarMovies? similarMovies = detailsScreenViewModel.similarResponses!.results!.isNotEmpty ? detailsScreenViewModel.similarResponses!.results![index] : null;
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 150,
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
                                                      create: (context) => DetailsScreenViewModel(id: similarMovies.id.toString()),
                                                      child: const DetailsScreen(),
                                                    ),
                                                    settings: RouteSettings(
                                                      arguments: {
                                                        'filmName': similarMovies.title ?? "no name",
                                                        'posterPath': similarMovies.posterPath ?? "image.1316918305.1116/st,small,845x845-pad,1000x1000,f8f8f8.jpg",
                                                        'backDropPath': similarMovies.backdropPath ?? "image.1316918305.1116/st,small,845x845-pad,1000x1000,f8f8f8.jpg",
                                                        'vote': similarMovies.voteAverage?.toString() ?? "no vote",
                                                        'overview': similarMovies.overview ?? "null",
                                                        'date': similarMovies.releaseDate ?? "no date",
                                                      },
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: ClipRRect(
                                                borderRadius:BorderRadius.circular(7),
                                                child: Image.network(
                                                  height : 200,
                                                  width : 150 ,
                                                  'https://image.tmdb.org/t/p/w200/${similarMovies!.posterPath ?? "image.1316918305.1116/st,small,845x845-pad,1000x1000,f8f8f8.jpg"}',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Consumer<FavoriteProvider>(
                                              builder: (context, favoriteProvider, _) {
                                                return BuildCustomPaint(movie: similarMovies,);
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
                                                similarMovies.voteAverage?.toString() ?? "without rate",
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
                                            similarMovies.title ?? "without name",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
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
                                            similarMovies.releaseDate ?? "without date",
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
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}
