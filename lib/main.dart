import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yolustunde_mobile/company_screens/CBottomNavBar/c_bottom_nav_bar.dart';
import 'package:yolustunde_mobile/providers/bottom_nav_bar_provider.dart';
import 'package:yolustunde_mobile/providers/cart_provider.dart';
import 'package:yolustunde_mobile/providers/data_provider.dart';
import 'package:yolustunde_mobile/providers/login_provider.dart';
import 'package:yolustunde_mobile/providers/register_provider.dart';
import 'package:yolustunde_mobile/providers/splash_provider.dart';
import 'package:yolustunde_mobile/providers/user_provider.dart';
import 'package:yolustunde_mobile/screens/Splash/splash.dart';
import 'package:yolustunde_mobile/services/secure_storage_service.dart';
import 'package:yolustunde_mobile/theme/colors.dart';

import 'providers/company_providers/c_bottom_nav_bar_provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => SplashProvider()),
        ChangeNotifierProvider(create: (context) => RegisterProvider()),
        ChangeNotifierProvider(create: (context) => BottomNavBarProvider()),
        ChangeNotifierProvider(create: (context) => CBottomNavBarProvider()),
        ChangeNotifierProvider(create: (context) => DataProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: MaterialApp(
          navigatorKey: navigatorKey,
          theme: ThemeData(
            fontFamily: 'Urbanist',
            scaffoldBackgroundColor: MyColors.white,
            primaryColor: MyColors.yellow,
            primarySwatch: Colors.amber,
            appBarTheme: const AppBarTheme(
              backgroundColor: MyColors.white,
              elevation: 0,
              iconTheme: IconThemeData(color: MyColors.black),
              titleTextStyle: TextStyle(color: MyColors.black, fontWeight: FontWeight.w600, fontFamily: 'Urbanist'),
            ),
          ),
          home: const SplashScreen(),
          // home: CBottomNavBar(),
        ),
      ),
    );
  }
}
