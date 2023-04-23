import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yolustunde_mobile/main.dart';
import 'package:yolustunde_mobile/models/dio/dio_response.dart';
import 'package:yolustunde_mobile/providers/user_provider.dart';
import 'package:yolustunde_mobile/screens/BottomNavBar/bottom_nav_bar.dart';
import 'package:yolustunde_mobile/screens/Home/home_screen.dart';
import 'package:yolustunde_mobile/services/dio_service.dart';
import 'package:yolustunde_mobile/services/secure_storage_service.dart';
import 'package:yolustunde_mobile/utils/my_snackbar.dart';

class RegisterProvider extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController(text: kDebugMode ? 'mirsaid@gmail.com' : null);
  final TextEditingController firstNameController = TextEditingController(text: kDebugMode ? 'mirsaid' : null);
  final TextEditingController lastNameController = TextEditingController(text: kDebugMode ? 'dev' : null);
  final TextEditingController phoneController = TextEditingController(text: kDebugMode ? '05525128799' : null);
  final TextEditingController passwordController = TextEditingController(text: kDebugMode ? '123456' : null);
  final TextEditingController password2Controller = TextEditingController(text: kDebugMode ? '123456' : null);

  BuildContext context = navigatorKey.currentState!.context;

  Future<void> register() async {
    if (firstNameController.text.isEmpty) {
      MySnackbar.show(context, message: 'Lütfen adınızı giriniz', title: 'Uyarı!');
      return;
    }
    if (lastNameController.text.isEmpty) {
      MySnackbar.show(context, message: 'Lütfen soyadınızı giriniz', title: 'Uyarı!');
      return;
    }
    if (phoneController.text.isEmpty) {
      MySnackbar.show(context, message: 'Lütfen telefon numaranızı giriniz', title: 'Uyarı!');
      return;
    }

    if (emailController.text.isEmpty) {
      MySnackbar.show(context, message: 'Lütfen email adresinizi giriniz', title: 'Uyarı!');
      return;
    }
    if (passwordController.text.isEmpty) {
      MySnackbar.show(context, message: 'Lütfen şifrenizi giriniz', title: 'Uyarı!');
      return;
    }
    if (passwordController.text != password2Controller.text) {
      MySnackbar.show(context, message: 'Şifreleriniz uyuşmuyor', title: 'Uyarı!');
      return;
    }

    DioResponse dioResponse = await DioService().request(
      'register',
      method: Method.post,
      data: {
        "first_name": firstNameController.text,
        "last_name": lastNameController.text,
        "phone": phoneController.text,
        "email": emailController.text,
        "password": passwordController.text,
      },
    );

    debugPrint(dioResponse.data.toString());

    if (dioResponse.isSuccessful) {
      String? token = dioResponse.data['token'];
      if (token != null) {
        await SecureStorageService().set(key: 'token', value: token);
        DioService().init();
        UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
        await userProvider.getUser();
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_context) => BottomNavBar()), (route) => false);
        MySnackbar.show(context, message: 'Giriş başarılı', title: 'Başarılı!');
      } else {
        MySnackbar.show(context, message: 'Bir hata oluştu!', title: 'Hata!');
      }
    } else {
      MySnackbar.show(context, message: dioResponse.data.isNotEmpty ? dioResponse.data['message'] : 'Giriş başarısız', title: 'Hata!');
    }
  }
}
