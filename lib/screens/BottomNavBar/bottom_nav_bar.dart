import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yolustunde_mobile/providers/bottom_nav_bar_provider.dart';
import 'package:yolustunde_mobile/providers/user_provider.dart';
import 'package:yolustunde_mobile/screens/Home/home_screen.dart';
import 'package:yolustunde_mobile/services/image_service.dart';
import 'package:yolustunde_mobile/theme/colors.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    BottomNavBarProvider bottomNavBarProvider = Provider.of<BottomNavBarProvider>(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      extendBody: true,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: GestureDetector(
          onTap: () {
            bottomNavBarProvider.changeIndex(2);
          },
          child: CircleAvatar(
            radius: 30,
            backgroundColor: MyColors.yellow,
            child: Image.asset(
              ImageService.pngIcon('shopping-cart'),
              height: 28,
              color: Colors.black,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
                child: Image.asset(ImageService.pngIcon('heart'), height: 24, color: itemColor(1)),
              ),
              label: 'Favoriler',
            ),
            BottomNavigationBarItem(icon: SizedBox(), label: ''),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 8.0, top: 4),
                child: Image.asset(ImageService.pngIcon('edit'), height: 24, color: itemColor(3)),
              ),
              label: 'Blog',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 8.0, top: 4),
                child: Image.asset(ImageService.pngIcon('messages'), height: 24, color: itemColor(4)),
              ),
              label: 'Forum',
            ),
          ],
        ),
      ),
      body: Builder(builder: (context) {
        // if (userProvider.userModel == null) {
        //   return Center(child: CircularProgressIndicator.adaptive());
        // }
        return bottomNavBarProvider.currentScreen;
      }),
    );
  }

  Color itemColor(index) {
    BottomNavBarProvider bottomNavBarProvider = Provider.of<BottomNavBarProvider>(context);
    if (index == bottomNavBarProvider.currentIndex) {
      return MyColors.yellow;
    } else {
      return MyColors.greyLight;
    }
  }
}
