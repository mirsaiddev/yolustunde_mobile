import 'package:flutter/material.dart';
import 'package:yolustunde_mobile/screens/Home/home_screen.dart';
import 'package:yolustunde_mobile/screens/Auth/email_login.dart';
import 'package:yolustunde_mobile/theme/colors.dart';
import 'package:yolustunde_mobile/widgets/my_button.dart';
import 'package:yolustunde_mobile/widgets/my_textfield.dart';

class PhoneLogin extends StatelessWidget {
  const PhoneLogin({Key? key}) : super(key: key);

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
                          text: 'Mail Adresi',
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => EmailLogin()));
                          },
                          height: 54,
                          width: double.infinity,
                          color: MyColors.grey,
                          textColor: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: MyButton(
                          text: 'Telefon Numarası',
                          onPressed: () {},
                          height: 54,
                          width: double.infinity,
                          textColor: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  MyTextfield(
                    hintText: 'Telefon Numarası',
                  ),
                  const SizedBox(height: 12),
                  MyTextfield(
                    hintText: 'Onay Kodu',
                  ),
                  const SizedBox(height: 12),
                  MyButton(
                    text: 'Giriş yap',
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
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
