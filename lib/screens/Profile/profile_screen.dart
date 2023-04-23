import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yolustunde_mobile/models/user/user_model.dart';
import 'package:yolustunde_mobile/providers/user_provider.dart';
import 'package:yolustunde_mobile/screens/AddressInformation/address_information.dart';
import 'package:yolustunde_mobile/screens/CarInfo/car_information.dart';
import 'package:yolustunde_mobile/screens/EditProfile/edit_profile.dart';
import 'package:yolustunde_mobile/screens/FaqScreen/faq_screen.dart';
import 'package:yolustunde_mobile/screens/Favorites/favorites_screen.dart';
import 'package:yolustunde_mobile/screens/Feedback/feedback_screen.dart';
import 'package:yolustunde_mobile/screens/MyOrders/my_orders_screen.dart';
import 'package:yolustunde_mobile/screens/MyTransactions/my_transactions.dart';
import 'package:yolustunde_mobile/screens/Settings/setting_screen.dart';
import 'package:yolustunde_mobile/services/image_service.dart';
import 'package:yolustunde_mobile/theme/colors.dart';
import 'package:yolustunde_mobile/widgets/my_app_bar.dart';
import 'package:yolustunde_mobile/widgets/my_list_tile.dart';
import 'package:yolustunde_mobile/widgets/my_profile_image_widget.dart';
import 'package:yolustunde_mobile/widgets/my_square_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    UserModel? userModel = userProvider.userModel;

    return Scaffold(
      appBar: buildAppBar(
        title: 'Profil',
        actions: [
          MySquareButton(
            child: Image.asset(
              ImageService.pngIcon('settings'),
              height: 24,
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SetttingScreen()));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    MyProfileImageWidget(
                      height: 58,
                      width: 58,
                      radius: 100,
                      border: true,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userModel?.firstName ?? '',
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 4),
                          Text(
                            userModel?.email ?? '',
                            style: TextStyle(color: MyColors.greyLight.withOpacity(0.8), fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              MyListTile(
                leading: Image.asset(
                  ImageService.pngIcon('profile'),
                  height: 24,
                ),
                title: 'Kişisel Bilgilerim',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile()));
                },
              ),
              SizedBox(height: 10),
              MyListTile(
                leading: Image.asset(
                  ImageService.pngIcon('profile'),
                  height: 24,
                ),
                title: 'İşlemlerim',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyTransactions()));
                },
              ),
              SizedBox(height: 10),
              MyListTile(
                leading: Image.asset(
                  ImageService.pngIcon('car'),
                  height: 24,
                ),
                title: 'Araç Bilgilerim',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CarInformation()));
                },
              ),
              SizedBox(height: 10),
              MyListTile(
                leading: Image.asset(
                  ImageService.pngIcon('copy'),
                  height: 24,
                ),
                title: 'Siparişlerim',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyOrders()));
                },
              ),
              SizedBox(height: 10),
              MyListTile(
                leading: Image.asset(
                  ImageService.pngIcon('heart'),
                  height: 24,
                  color: Colors.black,
                ),
                title: 'Favori İşletmeler',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FavoritesScreen()));
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
                  ImageService.pngIcon('people'),
                  height: 24,
                ),
                title: 'Bizimle İş Birliği Yap',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CarInformation()));
                },
              ),
              SizedBox(height: 10),
              MyListTile(
                leading: Image.asset(
                  ImageService.pngIcon('faq'),
                  height: 24,
                ),
                title: 'Sıkça Sorulan Sorular',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FaqScreen()));
                },
              ),
              SizedBox(height: 10),
              MyListTile(
                leading: Image.asset(
                  ImageService.pngIcon('sms-tracking'),
                  height: 24,
                ),
                title: 'Geri Bildirim Yap',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
