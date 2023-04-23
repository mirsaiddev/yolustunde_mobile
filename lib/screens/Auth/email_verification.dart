import 'package:flutter/material.dart';
import 'package:yolustunde_mobile/theme/colors.dart';
import 'package:yolustunde_mobile/widgets/my_button.dart';
import 'package:yolustunde_mobile/widgets/my_textfield.dart';

class EmailVerification extends StatelessWidget {
  const EmailVerification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Email Onayı',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'E-Mail adresinize gönderilen onay kodunu aşağıdaki alana yazarak üyeliğinizi tamamlayabilirsiniz',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 28),
              MyTextfield(
                hintText: 'Onay Kodu',
              ),
              SizedBox(height: 16),
              MyButton(
                text: 'Onayla',
                onPressed: () {},
                textColor: Colors.black,
              ),
              Row(
                children: [
                  Checkbox(value: true, onChanged: (val) {}, activeColor: MyColors.yellow),
                  Text(
                    'Üyelik sözleşmesini okudum ve kabul ediyorum',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
