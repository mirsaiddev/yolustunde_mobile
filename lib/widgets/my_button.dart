import 'package:flutter/material.dart';
import 'package:yolustunde_mobile/theme/colors.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    Key? key,
    this.color = MyColors.yellow,
    this.textColor = Colors.white,
    required this.text,
    this.onPressed,
    this.height = 54,
    this.width = double.infinity,
    this.icon,
    this.borderRadius = 16,
    this.borderColor,
  }) : super(key: key);

  final Color color;
  final Color textColor;
  final Color? borderColor;
  final String text;
  final void Function()? onPressed;
  final double height;
  final double width;
  final Widget? icon;

  final double borderRadius;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: borderColor != null ? BorderSide(color: borderColor!) : BorderSide.none,
          ),
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              icon!,
              const SizedBox(width: 14),
            ],
            Text(
              text,
              style: TextStyle(fontSize: 14, color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
