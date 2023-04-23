import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yolustunde_mobile/providers/user_provider.dart';
import 'package:yolustunde_mobile/services/image_service.dart';
import 'package:yolustunde_mobile/theme/colors.dart';
import 'package:yolustunde_mobile/utils/my_snackbar.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    super.key,
    required this.id,
  });
  final int id;

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    bool isFavorite = userProvider.favoriteCompanies.any((element) => element.id == id);

    return GestureDetector(
      onTap: () {
        userProvider.addFavorites(id).then((value) {
          MySnackbar.show(context, message: isFavorite ? 'Favorilerden çıkarıldı' : 'Favorilere eklendi');
        });
      },
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.6),
        ),
        padding: EdgeInsets.all(6),
        child: Image.asset(
          ImageService.pngIcon(isFavorite ? 'heart_filled' : 'heart'),
          color: isFavorite ? MyColors.yellow : Colors.white,
        ),
      ),
    );
  }
}
