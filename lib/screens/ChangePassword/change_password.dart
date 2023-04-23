import 'package:flutter/material.dart';
import 'package:yolustunde_mobile/models/dio/dio_response.dart';
import 'package:yolustunde_mobile/services/dio_service.dart';
import 'package:yolustunde_mobile/utils/my_snackbar.dart';
import 'package:yolustunde_mobile/widgets/my_app_bar.dart';
import 'package:yolustunde_mobile/widgets/my_button.dart';
import 'package:yolustunde_mobile/widgets/my_textfield.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController newPasswordAgainController = TextEditingController();

  Future<void> changePassword() async {
    if (oldPasswordController.text.isEmpty || newPasswordController.text.isEmpty || newPasswordAgainController.text.isEmpty) {
      MySnackbar.show(context, message: 'Lütfen tüm alanları doldurunuz');
      return;
    }
    if (newPasswordController.text != newPasswordAgainController.text) {
      MySnackbar.show(context, message: 'Yeni şifreler uyuşmuyor');
      return;
    }
    DioResponse dioResponse = await DioService().request('changepassword', method: Method.post, data: {
      'oldpassword': oldPasswordController.text,
      'newpassword': newPasswordController.text,
    });
    if (dioResponse.isSuccessful) {
      Navigator.pop(context);
      MySnackbar.show(context, message: 'Şifre değiştirildi');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: 'Şifre Değiştir'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              MyTextfield.white(
                hintText: 'Eski Şifre',
                suffixIcon: Icon(Icons.visibility),
              ),
              SizedBox(height: 16),
              MyTextfield.white(
                hintText: 'Yeni Şifre',
                suffixIcon: Icon(Icons.visibility),
              ),
              SizedBox(height: 16),
              MyTextfield.white(
                hintText: 'Yeni Şifre Tekrar',
                suffixIcon: Icon(Icons.visibility),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: MyButton(
            onPressed: changePassword,
            text: 'Değiştir',
            textColor: Colors.black,
          ),
        ),
      ),
    );
  }
}
