import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yolustunde_mobile/company_screens/CBottomNavBar/c_bottom_nav_bar.dart';
import 'package:yolustunde_mobile/models/dio/dio_response.dart';
import 'package:yolustunde_mobile/providers/user_provider.dart';
import 'package:yolustunde_mobile/screens/BottomNavBar/bottom_nav_bar.dart';
import 'package:yolustunde_mobile/screens/Home/home_screen.dart';
import 'package:yolustunde_mobile/services/dio_service.dart';
import 'package:yolustunde_mobile/services/secure_storage_service.dart';
import 'package:yolustunde_mobile/utils/my_snackbar.dart';

import '../main.dart';

class LoginProvider extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController(text: 'musteri@example.com'); //kDebugMode ? 'musteri@example.com' : null);
  final TextEditingController passwordController = TextEditingController(text: 'testtest'); // kDebugMode ? 'testtest' : null);

  BuildContext context = navigatorKey.currentState!.context;

  bool emailLogin = true;

  void notify() {
    notifyListeners();
  }

  Future<void> login({bool company = false}) async {
    if (emailController.text.isEmpty) {
      MySnackbar.show(context, message: 'Lütfen email adresinizi giriniz', title: 'Uyarı!');
      return;
    }
    if (passwordController.text.isEmpty) {
      MySnackbar.show(context, message: 'Lütfen şifrenizi giriniz', title: 'Uyarı!');
      return;
    }

    DioResponse dioResponse = await DioService().request(
      'login',
      method: Method.post,
      data: {
        'email': emailController.text,
        'password': passwordController.text,
      },
    );

    if (dioResponse.isSuccessful) {
      String? token = dioResponse.data['token'];
      if (token != null) {
        await SecureStorageService().set(key: 'token', value: token);
        await DioService().init();
        UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
        await userProvider.getUser();
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_context) => company ? CBottomNavBar() : BottomNavBar()), (route) => false);
        MySnackbar.show(context, message: 'Giriş başarılı', title: 'Başarılı!');
      } else {
        MySnackbar.show(context, message: 'Bir hata oluştu!', title: 'Hata!');
      }
    } else {
      MySnackbar.show(context, message: dioResponse.data.isNotEmpty ? dioResponse.data['message'] : 'Giriş başarısız', title: 'Hata!');
    }
  }
}
