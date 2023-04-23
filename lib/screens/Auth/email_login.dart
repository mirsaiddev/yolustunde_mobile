import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yolustunde_mobile/providers/login_provider.dart';
import 'package:yolustunde_mobile/screens/Auth/phone_login.dart';
import 'package:yolustunde_mobile/theme/colors.dart';
import 'package:yolustunde_mobile/widgets/my_button.dart';
import 'package:yolustunde_mobile/widgets/my_textfield.dart';

class EmailLogin extends StatelessWidget {
  const EmailLogin({Key? key, this.company = false}) : super(key: key);

  final bool company;

  @override
  Widget build(BuildContext context) {
    LoginProvider loginProvider = Provider.of<LoginProvider>(context);
    return Scaffold(
      backgroundColor: MyColors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Container(
              child: Center(
                child: Text(
                  'Resim',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Yol Üstündeki Dostunuz',
                    style: TextStyle(
                      color: MyColors.yellow,
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Aracın ile ilgili ihtiyaç duyabileceğin her şey bu uygulamada. Hemen giriş yap keşfetmeye başla',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 22),
                  Row(
                    children: [
                      Expanded(
                        child: MyButton(
                          text: 'Mail Adresi',
                          onPressed: () {
                            loginProvider.emailLogin = true;
                            loginProvider.notify();
                          },
                          height: 54,
                          width: double.infinity,
                          color: loginProvider.emailLogin ? MyColors.yellow : MyColors.grey,
                          textColor: loginProvider.emailLogin ? Colors.black : Colors.white,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: MyButton(
                          text: 'Telefon Numarası',
                          onPressed: () {
                            loginProvider.emailLogin = false;
                            loginProvider.notify();
                          },
                          height: 54,
                          color: loginProvider.emailLogin ? MyColors.grey : MyColors.yellow,
                          width: double.infinity,
                          textColor: loginProvider.emailLogin ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  MyTextfield(
                    hintText: 'E-Mail',
                    controller: loginProvider.emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 12),
                  MyTextfield(
                    hintText: 'Şifre',
                    controller: loginProvider.passwordController,
                    obscureText: kDebugMode ? false : true,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  const SizedBox(height: 12),
                  MyButton(
                    text: 'Giriş yap',
                    onPressed: () {
                      loginProvider.login(company: company);
                    },
                    height: 54,
                    width: double.infinity,
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
