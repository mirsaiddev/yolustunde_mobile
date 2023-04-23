import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yolustunde_mobile/providers/register_provider.dart';
import 'package:yolustunde_mobile/theme/colors.dart';
import 'package:yolustunde_mobile/widgets/dialogs/last_step_dialog.dart';
import 'package:yolustunde_mobile/widgets/my_button.dart';
import 'package:yolustunde_mobile/widgets/my_textfield.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RegisterProvider registerProvider = Provider.of<RegisterProvider>(context);
    return Scaffold(
      backgroundColor: MyColors.black,
      body: SafeArea(
        child: Column(
          children: [
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kayıt Ol',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Bilgilerini eksiksiz girerek kayıt işlemini tamamlayabilir ve uygulamayı kullanmaya başlayabilirsin',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 28),
                  MyTextfield(
                    hintText: 'Ad',
                    controller: registerProvider.firstNameController,
                  ),
                  SizedBox(height: 16),
                  MyTextfield(
                    hintText: 'Soyad',
                    controller: registerProvider.lastNameController,
                  ),
                  SizedBox(height: 16),
                  MyTextfield(
                    hintText: 'E-Mail',
                    controller: registerProvider.emailController,
                  ),
                  SizedBox(height: 16),
                  MyTextfield(
                    hintText: 'Telefon',
                    controller: registerProvider.phoneController,
                  ),
                  SizedBox(height: 16),
                  MyTextfield(
                    hintText: 'Şifre',
                    controller: registerProvider.passwordController,
                  ),
                  SizedBox(height: 16),
                  MyTextfield(
                    hintText: 'Şifre (tekrar)',
                    controller: registerProvider.password2Controller,
                  ),
                  SizedBox(height: 16),
                  MyButton(
                    text: 'Devam Et',
                    onPressed: registerProvider.register,
                    // showDialog(
                    //   context: context,
                    //   builder: (context) => LastStepDialog(),
                    // );
                    // },
                    textColor: Colors.black,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
