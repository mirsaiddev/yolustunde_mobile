import 'package:flutter/material.dart';
import 'package:yolustunde_mobile/theme/colors.dart';
import 'package:yolustunde_mobile/widgets/my_button.dart';

class LastStepDialog extends StatelessWidget {
  const LastStepDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      backgroundColor: MyColors.grey,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 22, vertical: 30),
        decoration: BoxDecoration(border: Border.all(color: MyColors.grey.withOpacity(0.8), width: 1), borderRadius: BorderRadius.circular(30)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Son Adım',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: MyColors.yellow),
            ),
            SizedBox(height: 6),
            Text(
              'Hesabınızı onaylamak için mail veya sms onay sürecini tamamlamalısın.',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white.withOpacity(0.7)),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 28),
            MyButton(
              height: 40,
              color: MyColors.grey.withOpacity(0.8),
              text: 'SMS ile onayla',
              onPressed: () {},
              borderRadius: 11,
            ),
            SizedBox(height: 10),
            MyButton(
              height: 40,
              color: MyColors.grey.withOpacity(0.8),
              text: 'E-mail ile onayla',
              onPressed: () {},
              borderRadius: 11,
            ),
          ],
        ),
      ),
    );
  }
}
