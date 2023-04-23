import 'package:flutter/material.dart';
import 'package:yolustunde_mobile/services/image_service.dart';
import 'package:yolustunde_mobile/theme/colors.dart';

class MySquareButton extends StatelessWidget {
  const MySquareButton({
    super.key,
    required this.child,
    this.badge,
    this.onTap,
  });

  final Widget child;
  final Widget? badge;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: MyColors.greyLightest.withOpacity(0.5)),
              ),
              padding: EdgeInsets.all(10),
              child: child,
              height: 44,
              width: 44,
            ),
          ),
          if (badge != null)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(color: MyColors.yellow, borderRadius: BorderRadius.circular(15)),
                height: 16,
                width: 16,
                child: badge,
              ),
            ),
        ],
      ),
    );
  }
}
