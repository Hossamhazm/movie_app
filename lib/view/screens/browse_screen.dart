import 'package:flutter/material.dart';
import 'package:movie_app/models/utilities/color_utility.dart';
import 'package:movie_app/view/screens/details_movie_according_gender.dart';
import 'package:movie_app/viewModel/browse_screen_view_model.dart';
import 'package:provider/provider.dart';
import '../../viewModel/movies_according_gener_view_model.dart';


class BrowseScreen extends StatelessWidget {
  const BrowseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ChangeNotifierProvider<BrowseScreenViewModel>(
        create: (context) => BrowseScreenViewModel(),
        child: Consumer<BrowseScreenViewModel>(
          builder: (context, browseScreenViewModel, _) {
            return Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      "Browse Category",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                browseScreenViewModel.isLoading
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : browseScreenViewModel.error.isNotEmpty
                    ? Center(
                  child: Text(
                    browseScreenViewModel.error,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
                    : Expanded(
                  child: GridView.builder(
                    gridDelegate:
                    const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: browseScreenViewModel.moviesCategoriesResponses!.genres!.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChangeNotifierProvider<MovieAccordingGenerViewModel>(
                                create: (context) => MovieAccordingGenerViewModel(),
                                child: const DetailsMovieAccordingGender(),
                              ),
                              settings: RouteSettings(
                                arguments: {
                                  'filmGener': browseScreenViewModel.moviesCategoriesResponses!.genres![index].name ?? "no name",
                                  'id' : browseScreenViewModel.moviesCategoriesResponses!.genres![index].id?.toString() ?? "null"
                                },
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.selectedIconsColor,
                            ),
                            child: Text(browseScreenViewModel.moviesCategoriesResponses!.genres![index].name ?? "null",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w600
                            ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}