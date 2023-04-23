import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yolustunde_mobile/models/user/user_model.dart';
import 'package:yolustunde_mobile/providers/bottom_nav_bar_provider.dart';
import 'package:yolustunde_mobile/providers/user_provider.dart';
import 'package:yolustunde_mobile/screens/Balance/balance_screen.dart';
import 'package:yolustunde_mobile/screens/MapScreen/map_screen.dart';
import 'package:yolustunde_mobile/screens/Notifications/notifications_screen.dart';
import 'package:yolustunde_mobile/screens/Profile/profile_screen.dart';
import 'package:yolustunde_mobile/services/image_service.dart';
import 'package:yolustunde_mobile/theme/colors.dart';
import 'package:yolustunde_mobile/widgets/my_profile_image_widget.dart';
import 'package:yolustunde_mobile/widgets/my_square_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    UserModel? userModel = userProvider.userModel;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
                    },
                    child: Row(
                      children: [
                        MyProfileImageWidget(),
                        const SizedBox(width: 6),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Hoş Geldin', style: TextStyle(fontSize: 12, color: MyColors.greyLight.withOpacity(0.8))),
                            Text('${userModel?.firstName}', style: TextStyle(fontSize: 16, color: MyColors.black, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  MySquareButton(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen()));
                    },
                    child: Image.asset(ImageService.pngIcon('notification')),
                    badge: Center(
                      child: Text(
                        '2',
                        style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  SizedBox(width: 4),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => BalanceScreen()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: MyColors.greyLightest.withOpacity(0.5)),
                      ),
                      height: 44,
                      padding: EdgeInsets.symmetric(horizontal: 14),
                      child: Center(
                        child: Text('₺128.72', style: TextStyle(fontSize: 16, color: MyColors.black, fontWeight: FontWeight.w700)),
                      ),
                    ),
                  ),
                  SizedBox(width: 4),
                  MySquareButton(
                    onTap: () {
                      BottomNavBarProvider bottomNavBarProvider = Provider.of<BottomNavBarProvider>(context, listen: false);
                      bottomNavBarProvider.changeIndex(2);
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => Sepetim()));
                    },
                    child: Image.asset(ImageService.pngIcon('bag')),
                    badge: Center(
                      child: Text(
                        '2',
                        style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Expanded(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MapsScreen(type: 'gas')));
                      },
                      child: Image.asset(ImageService.image('map')),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                HomeContainer(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => MapsScreen(type: 'gas')));
                                  },
                                  title: 'Benzin İstasyonları',
                                  description: 'En yakın benzin istasyonlarını bul!',
                                  imagePath: 'gas',
                                  flex: 3,
                                ),
                                SizedBox(height: 10),
                                HomeContainer(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => MapsScreen(type: 'park')));
                                  },
                                  title: 'Otopark ',
                                  description: 'En yakın otoparkı bul!',
                                  imagePath: 'park',
                                  flex: 2,
                                ),
                                SizedBox(height: 10),
                                HomeContainer(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => MapsScreen(type: 'tire')));
                                  },
                                  title: 'Oto Lastik ',
                                  description: 'En yakın oto lastik işletmelerini bul!',
                                  imagePath: 'wheel',
                                  flex: 2,
                                ),
                                SizedBox(height: 10),
                                HomeContainer(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => MapsScreen(type: 'help')));
                                  },
                                  title: 'Yol Yardım ',
                                  description: 'En yakın yol yardım işletmelerini bul!',
                                  imagePath: 'truck',
                                  flex: 2,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              children: [
                                HomeContainer(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => MapsScreen(type: 'washing')));
                                  },
                                  title: 'Oto Yıkama ',
                                  description: 'En yakın oto yıkama işletmelerini bul!',
                                  imagePath: 'car',
                                  flex: 2,
                                ),
                                SizedBox(height: 10),
                                HomeContainer(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => MapsScreen(type: 'service')));
                                  },
                                  title: 'Yetkili Servis ',
                                  description: 'En yakın yetkili servis işletmelerini bul!',
                                  imagePath: 'repair',
                                  flex: 3,
                                ),
                                SizedBox(height: 10),
                                HomeContainer(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => MapsScreen(type: 'expert')));
                                  },
                                  title: 'Oto Ekspertiz ',
                                  description: 'En yakın ekspertiz işletmelerini bul!',
                                  imagePath: 'expert',
                                  flex: 2,
                                ),
                                SizedBox(height: 10),
                                HomeContainer(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => MapsScreen(type: 'tuning')));
                                  },
                                  title: 'Oto Tuning ',
                                  description: 'En yakın oto tuning işletmelerini bul!',
                                  imagePath: 'car-2',
                                  flex: 2,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeContainer extends StatelessWidget {
  const HomeContainer({
    Key? key,
    this.flex = 1,
    required this.title,
    required this.description,
    required this.imagePath,
    this.onTap,
  }) : super(key: key);

  final int flex;
  final String title;
  final String description;
  final String imagePath;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 40,
                offset: Offset(10, 10),
              ),
            ],
          ),
          width: double.infinity,
          child: Stack(
            children: [
              Positioned(
                right: 8,
                bottom: 0,
                child: Opacity(
                  child: Image.asset(
                    ImageService.image(imagePath),
                  ),
                  opacity: 0.8,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(fontSize: 14, color: MyColors.greyLight, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
