import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:yolustunde_mobile/models/user/user_model.dart';
import 'package:yolustunde_mobile/providers/user_provider.dart';
import 'package:yolustunde_mobile/screens/CarInfo/car_information.dart';
import 'package:yolustunde_mobile/screens/EditProfile/edit_profile.dart';
import 'package:yolustunde_mobile/screens/Favorites/favorites_screen.dart';
import 'package:yolustunde_mobile/screens/Feedback/feedback_screen.dart';
import 'package:yolustunde_mobile/screens/MyOrders/my_orders_screen.dart';
import 'package:yolustunde_mobile/services/image_service.dart';
import 'package:yolustunde_mobile/theme/colors.dart';
import 'package:yolustunde_mobile/widgets/my_app_bar.dart';
import 'package:yolustunde_mobile/widgets/my_button.dart';
import 'package:yolustunde_mobile/widgets/my_list_tile.dart';

class SetttingScreen extends StatelessWidget {
  const SetttingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    UserModel? userModel = userProvider.userModel;

    return Scaffold(
      appBar: buildAppBar(
        title: 'Ayarlar',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              MyListTile(
                leading: Image.asset(
                  ImageService.pngIcon('translate'),
                  height: 24,
                ),
                title: 'Dil Seçeneği',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile()));
                },
              ),
              // SizedBox(height: 10),
              // MyListTile(
              //   leading: Image.asset(
              //     ImageService.pngIcon('profile'),
              //     height: 24,
              //   ),
              //   title: 'Para Birimi',
              //   onTap: () {
              //     Navigator.push(context, MaterialPageRoute(builder: (context) => MyTransactions()));
              //   },
              // ),
              SizedBox(height: 10),
              MyListTile(
                leading: Image.asset(
                  ImageService.pngIcon('notification'),
                  height: 24,
                ),
                title: 'Bildirimler',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CarInformation()));
                },
              ),
              SizedBox(height: 10),
              MyListTile(
                leading: Image.asset(
                  ImageService.pngIcon('task-square'),
                  height: 24,
                ),
                title: 'Kullanım Şartları',
                onTap: () {
                  launchUrlString('http://centirir.com/satis.pdf');
                },
              ),
              SizedBox(height: 10),
              MyListTile(
                leading: Image.asset(
                  ImageService.pngIcon('security-safe'),
                  height: 24,
                  color: Colors.black,
                ),
                title: 'Gizlilik Politikası',
                onTap: () {
                  launchUrlString('http://centirir.com/gizlilik.pdf');
                },
              ),
              // SizedBox(height: 10),
              // MyListTile(
              //   leading: Image.asset(
              //     ImageService.pngIcon('medal-star'),
              //     height: 24,
              //   ),
              //   title: 'Kampanyalar',
              //   onTap: () {
              //     Navigator.push(context, MaterialPageRoute(builder: (context) => CarInformation()));
              //   },
              // ),
              SizedBox(height: 10),
              MyListTile(
                leading: Image.asset(
                  ImageService.pngIcon('info'),
                  height: 24,
                ),
                title: 'Hakkımızda',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CarInformation()));
                },
              ),
              SizedBox(height: 10),
              MyListTile(
                leading: Image.asset(
                  ImageService.pngIcon('bubble'),
                  height: 24,
                ),
                title: 'Versiyon',
                trailing: Text('16.0.2', style: TextStyle(color: MyColors.greyLight)),
                showTrailing: false,
              ),
              SizedBox(height: 10),
              MyListTile(
                leading: Image.asset(
                  ImageService.pngIcon('profile-delete'),
                  height: 24,
                ),
                title: 'Hesap Sil',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackScreen()));
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: MyButton(
            color: Colors.black,
            onPressed: () {
              userProvider.logout();
            },
            text: 'Çıkış Yap',
          ),
        ),
      ),
    );
  }
}
