import 'package:flutter/material.dart';
import 'package:yolustunde_mobile/company_screens/Category/category_screen.dart';
import 'package:yolustunde_mobile/company_screens/HomeScreen/c_home_screen.dart';
import 'package:yolustunde_mobile/company_screens/Statistics/statistics_screen.dart';

class CBottomNavBarProvider extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void changeIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  List<Widget> _screens = [
    CHomeScreen(),
    StatisticsScreen(),
    Container(),
    Container(),
    CategoryScreen(),
  ];

  Widget get currentScreen => _screens[_currentIndex];
}
