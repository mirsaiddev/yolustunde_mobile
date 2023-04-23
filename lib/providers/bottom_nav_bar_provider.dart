import 'package:flutter/material.dart';
import 'package:yolustunde_mobile/screens/BlogScreen/blog_screen.dart';
import 'package:yolustunde_mobile/screens/CartScreen/cart_screen.dart';
import 'package:yolustunde_mobile/screens/Favorites/favorites_screen.dart';
import 'package:yolustunde_mobile/screens/ForumScreen/forum_screen.dart';

import 'package:yolustunde_mobile/screens/Home/home_screen.dart';

class BottomNavBarProvider extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void changeIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  List<Widget> _screens = [
    HomeScreen(),
    FavoritesScreen(),
    CartScreen(),
    BlogScreen(),
    ForumScreen(),
  ];

  Widget get currentScreen => _screens[_currentIndex];
}
