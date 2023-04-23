import 'package:flutter/material.dart';
import 'package:yolustunde_mobile/main.dart';
import 'package:yolustunde_mobile/services/image_service.dart';
import 'package:yolustunde_mobile/widgets/my_square_button.dart';

AppBar buildAppBar({
  String? title,
  bool showBackButton = true,
  List<Widget>? actions,
  Color? color,
}) {
  return AppBar(
    backgroundColor: color,
    title: title != null ? Text(title) : null,
    automaticallyImplyLeading: false,
    centerTitle: true,
    leading: showBackButton && Navigator.canPop(navigatorKey.currentState!.context)
        ? Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: MySquareButton(
              child: Image.asset(
                ImageService.pngIcon('arrow-left'),
                height: 24,
              ),
              onTap: () {
                Navigator.pop(navigatorKey.currentContext!);
              },
            ),
          )
        : null,
    leadingWidth: 70,
    actions: [
      Center(
        child: Row(
          children: [
            if (actions != null) ...actions,
            SizedBox(width: 16),
          ],
        ),
      )
    ],
  );
}
