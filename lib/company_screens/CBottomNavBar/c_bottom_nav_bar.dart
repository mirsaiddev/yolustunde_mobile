import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yolustunde_mobile/providers/bottom_nav_bar_provider.dart';
import 'package:yolustunde_mobile/providers/company_providers/c_bottom_nav_bar_provider.dart';
import 'package:yolustunde_mobile/providers/user_provider.dart';
import 'package:yolustunde_mobile/screens/Home/home_screen.dart';
import 'package:yolustunde_mobile/services/image_service.dart';
import 'package:yolustunde_mobile/theme/colors.dart';

class CBottomNavBar extends StatefulWidget {
  const CBottomNavBar({Key? key}) : super(key: key);

  @override
  State<CBottomNavBar> createState() => _CBottomNavBarState();
}

class _CBottomNavBarState extends State<CBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    CBottomNavBarProvider bottomNavBarProvider = Provider.of<CBottomNavBarProvider>(context);
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.black,
          primaryColor: Colors.red,
          textTheme: Theme.of(context).textTheme.copyWith(caption: new TextStyle(color: Colors.yellow)),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: MyColors.yellow,
          unselectedItemColor: MyColors.greyLight,
          currentIndex: bottomNavBarProvider.currentIndex,
          onTap: (index) {
            bottomNavBarProvider.changeIndex(index);
          },
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 8.0, top: 4),
                child: Image.asset(ImageService.pngIcon('home'), height: 24, color: itemColor(0)),
              ),
              label: 'Anasayfa',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 8.0, top: 4),
                child: Image.asset(ImageService.pngIcon('stats'), height: 24, color: itemColor(1)),
              ),
              label: 'İstatistik',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 8.0, top: 4),
                child: Image.asset(ImageService.pngIcon('shopping-cart-outlined'), height: 24, color: itemColor(2)),
              ),
              label: 'Siparişlerim',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 8.0, top: 4),
                child: Image.asset(ImageService.pngIcon('edit'), height: 24, color: itemColor(3)),
              ),
              label: 'Mesajlar',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 8.0, top: 4),
                child: Image.asset(ImageService.pngIcon('menu'), height: 24, color: itemColor(4)),
              ),
              label: 'Kategori',
            ),
          ],
        ),
      ),
      body: Builder(builder: (context) {
        return bottomNavBarProvider.currentScreen;
      }),
    );
  }

  Color itemColor(index) {
    CBottomNavBarProvider bottomNavBarProvider = Provider.of<CBottomNavBarProvider>(context);
    if (index == bottomNavBarProvider.currentIndex) {
      return MyColors.yellow;
    } else {
      return MyColors.greyLight;
    }
  }
}
