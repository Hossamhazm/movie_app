import 'package:flutter/material.dart';
import 'package:movie_app/view/screens/splash_screen.dart';
import 'package:movie_app/viewModel/favourite_view_model.dart';
import 'package:movie_app/viewModel/home_screen_view_model.dart';

import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => MovieViewModel()),
    ChangeNotifierProvider(create: (_) => FavoriteProvider()),
  ],
  child: const MyApp(),
),);

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: "Movies App",
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
    );
  }

}
