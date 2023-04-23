import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:yolustunde_mobile/main.dart';
import 'package:yolustunde_mobile/screens/Auth/email_login.dart';
import 'package:yolustunde_mobile/screens/Auth/register_screen.dart';
import 'package:yolustunde_mobile/theme/colors.dart';
import 'package:yolustunde_mobile/widgets/my_button.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                          text: 'Giriş Yap',
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => EmailLogin()));
                          },
                          height: 54,
                          width: double.infinity,
                          textColor: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: MyButton(
                          text: 'Kayıt Ol',
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
                          },
                          height: 54,
                          width: double.infinity,
                          textColor: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  MyButton(
                    text: 'İşletme Giriş',
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => EmailLogin(company: true)));
                    },
                    height: 54,
                    width: double.infinity,
                    textColor: Colors.black,
                  ),
                  const SizedBox(height: 12),
                  MyButton(
                    icon: Image.asset(
                      'lib/assets/icons/google.png',
                      height: 22,
                    ),
                    color: MyColors.grey.withOpacity(0.8),
                    text: 'Google ile giriş yap',
                    onPressed: () {},
                    height: 54,
                    width: double.infinity,
                  ),
                  const SizedBox(height: 12),
                  MyButton(
                    icon: Image.asset(
                      'lib/assets/icons/apple.png',
                      height: 22,
                    ),
                    color: MyColors.grey.withOpacity(0.8),
                    text: 'Apple ile giriş yap',
                    onPressed: () {},
                    height: 54,
                    width: double.infinity,
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
