import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yolustunde_mobile/company_screens/CBottomNavBar/c_bottom_nav_bar.dart';
import 'package:yolustunde_mobile/main.dart';
import 'package:yolustunde_mobile/models/user/user_model.dart';
import 'package:yolustunde_mobile/providers/user_provider.dart';
import 'package:yolustunde_mobile/screens/Auth/auth_screen.dart';
import 'package:yolustunde_mobile/screens/BottomNavBar/bottom_nav_bar.dart';
import 'package:yolustunde_mobile/services/dio_service.dart';
import 'package:yolustunde_mobile/services/secure_storage_service.dart';

class SplashProvider extends ChangeNotifier {
  BuildContext context = navigatorKey.currentState!.context;

  DioService dioService = DioService();

  Future<void> init() async {
    // await SecureStorageService().delete(key: 'token');
    String? token = await SecureStorageService().get(key: 'token');
    bool loggedIn = token != null;
    if (loggedIn) {
      print('token $token');
    }

    Future.delayed(const Duration(seconds: 1), () async {
      if (loggedIn) {
        UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
        await userProvider.getUser();
        UserModel? user = userProvider.userModel;
        if (user != null) {
          if (user.company == null) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const BottomNavBar()),
              (route) => false,
            );
          } else {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const CBottomNavBar()),
              (route) => false,
            );
          }
        }
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const AuthScreen()),
          (route) => false,
        );
      }
    });
  }
}
