import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/responses/SearchResponces.dart';
import '../../viewModel/search_screen_view_model.dart';

class MovieItems extends StatelessWidget {
  double height;
  double width;
  MovieItems({Key? key, required this.width, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SearchScreenViewModel searchScreenViewModel = Provider.of<SearchScreenViewModel>(context);
    List<SearchResults>? searchResultsList = searchScreenViewModel.searchResponses?.results;

    return ListView.builder(
      itemCount: searchResultsList?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        SearchResults? searchResults = searchResultsList?[index];
        return searchScreenViewModel.isLoading
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : searchScreenViewModel.error.isNotEmpty
            ? Center(
          child: Text(
            searchScreenViewModel.error,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
            : Container(
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
                                      'https://image.tmdb.org/t/p/w200/${searchResults!.posterPath ?? "image.1316918305.1116/st,small,845x845-pad,1000x1000,f8f8f8.jpg"}',
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
                                searchResults?.title ?? "no name",
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
                                searchResults?.releaseDate ?? "no date",
                                style: const TextStyle(
                                  color: Colors.white70,//70
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Text(
                              searchResults?.originalTitle ?? "no title founded",
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


/*https://image.tmdb.org/t/p/w200/${searchResults!.posterPath*/