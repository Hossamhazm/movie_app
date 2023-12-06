import 'package:flutter/material.dart';
import 'package:movie_app/view/screens/search_screen.dart';
import 'package:movie_app/view/screens/watch_list_screen.dart';
import 'package:movie_app/viewModel/home_screen_view_model.dart';
import 'package:provider/provider.dart';

import '../../models/utilities/color_utility.dart';
import '../../models/utilities/text_utility.dart';
import 'browse_screen.dart';
import 'movies_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List<Widget> appTabs = [
  const MovieScreen(),
  const SearchScreen(),
  const BrowseScreen(),
  const FavoriteScreen(),
];

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    MovieViewModel movieViewModel = Provider.of(context , listen: true);

    List<BottomNavigationBarItem> bottomNavBar = [
      BottomNavigationBarItem(
        icon: ImageIcon(
          AssetImage(AppTexts.homeIcon),
        ),
        label: "HOME",
      ),
      BottomNavigationBarItem(
        icon: ImageIcon(AssetImage(AppTexts.searchIcon)),
        label: "SEARCH",
      ),
      BottomNavigationBarItem(
          icon: ImageIcon(AssetImage(AppTexts.browseIcon)), label: "BROWSE"),
      BottomNavigationBarItem(
          icon: ImageIcon(AssetImage(AppTexts.watchlistIcon)), label: "WATCHLIST"),
    ];

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: appTabs[movieViewModel.currentIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: AppColors.secondaryColor,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: AppColors.selectedIconsColor,
            unselectedItemColor: Colors.white,
          ),
        ),
        child: BottomNavigationBar(
          iconSize: 30,
          currentIndex: movieViewModel.currentIndex,
          onTap: movieViewModel.tabsToggle,
          items: bottomNavBar,
        ),
      ),
    );
  }
}
