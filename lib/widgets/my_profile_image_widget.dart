import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yolustunde_mobile/models/user/user_model.dart';
import 'package:yolustunde_mobile/providers/user_provider.dart';
import 'package:yolustunde_mobile/theme/colors.dart';

class MyProfileImageWidget extends StatelessWidget {
  const MyProfileImageWidget({
    super.key,
    this.height = 44,
    this.width = 44,
    this.radius = 15,
    this.border = false,
    this.borderColor = MyColors.yellow,
  });

  final double height;
  final double width;
  final double radius;
  final bool border;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    UserModel? userModel = userProvider.userModel;
    String? imageUrl = ''; //! buraya modele eklenen resim gelecek
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(radius),
        image: imageUrl.isEmpty ? null : DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover),
        border: border ? Border.all(color: borderColor, width: 2) : null,
      ),
      height: height,
      width: width,
      child: imageUrl.isEmpty
          ? Center(
              child: Text(
                userModel?.firstName.substring(0, 1).toUpperCase() ?? '',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          : null,
    );
  }
}
