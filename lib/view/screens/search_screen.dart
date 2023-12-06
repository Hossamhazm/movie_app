import 'package:flutter/material.dart';
import 'package:movie_app/view/screens/search_delegate_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: (){
                  showSearch(context: context, delegate: MovieSearchDelegate());
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: const Row (
                    children:[
                      SizedBox(width: 10,),
                      Icon(Icons.search,color: Colors.white,),
                      SizedBox(width: 20,),
                      Text("search",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19
                      ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/no_search.png"),
                  const SizedBox(height: 7,),
                  const Text("No movies found",
                  style: TextStyle(
                    color: Colors.grey
                  ),
                  )
                ],
              ),
            )
          ],
        ),
    );
  }
}
