import 'package:flutter/material.dart';
import 'package:yolustunde_mobile/theme/colors.dart';

class StatisticWidget extends StatelessWidget {
  const StatisticWidget({
    super.key,
    required this.title,
    this.subtitle,
    required this.value,
    this.unit,
    this.onTap,
  });

  final String title;
  final String? subtitle;
  final String value;
  final String? unit;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: MyColors.greyLight2),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 15, color: MyColors.black, fontWeight: FontWeight.w600),
                ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: TextStyle(fontSize: 12, color: MyColors.greyLight.withOpacity(0.8), fontWeight: FontWeight.w600),
                  ),
              ],
            ),
            Spacer(),
            Container(
              height: 96,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 15,
                  color: MyColors.yellow.withOpacity(0.56),
                  strokeAlign: BorderSide.strokeAlignInside,
                ),
                shape: BoxShape.circle,
              ),
              child: Container(
                height: 70,
                width: 70,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      value,
                      style: TextStyle(fontSize: 22, color: MyColors.black, fontWeight: FontWeight.w600),
                    ),
                    if (unit != null)
                      Text(
                        unit!,
                        style: TextStyle(fontSize: 10, color: MyColors.greyLight.withOpacity(0.8), fontWeight: FontWeight.w500),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
