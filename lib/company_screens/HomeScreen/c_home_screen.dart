import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:yolustunde_mobile/company_screens/CProfile/c_profile_screen.dart';
import 'package:yolustunde_mobile/company_screens/Products/products_screen.dart';
import 'package:yolustunde_mobile/models/dio/dio_response.dart';
import 'package:yolustunde_mobile/models/notification_model.dart';
import 'package:yolustunde_mobile/models/user/user_model.dart';
import 'package:yolustunde_mobile/providers/user_provider.dart';
import 'package:yolustunde_mobile/theme/colors.dart';
import 'package:yolustunde_mobile/widgets/my_button.dart';
import 'package:yolustunde_mobile/widgets/my_list_tile.dart';
import 'package:yolustunde_mobile/widgets/my_profile_image_widget.dart';
import 'package:yolustunde_mobile/widgets/statistics_widget.dart';

import '../../services/dio_service.dart';

class CHomeScreen extends StatefulWidget {
  const CHomeScreen({Key? key}) : super(key: key);

  @override
  State<CHomeScreen> createState() => _CHomeScreenState();
}

class _CHomeScreenState extends State<CHomeScreen> {
  @override
  void initState() {
    super.initState();
    getStatistics();
    getNotifications();
  }

  void getNotifications() {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.getNotifications();
  }

  Map statistics = {};

  Future<void> getStatistics() async {
    DioResponse dioResponse = await DioService().request('company/info');
    if (dioResponse.isSuccessful) {
      setState(() {
        statistics = dioResponse.data['data'];
      });
    }
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    UserModel? userModel = userProvider.userModel;
    List<NotificationModel> notifications = userProvider.notifications;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CProfileScreen()));
                          },
                          child: MyProfileImageWidget(),
                        ),
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
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: MyButton(
                      text: 'Genel Bakış',
                      onPressed: () {
                        setState(() {
                          selectedIndex = 0;
                        });
                      },
                      height: 45,
                      width: double.infinity,
                      color: selectedIndex == 0 ? MyColors.yellow : Colors.white,
                      textColor: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: MyButton(
                      text: 'Bildirimler',
                      borderColor: MyColors.greyLight2,
                      onPressed: () {
                        setState(() {
                          selectedIndex = 1;
                        });
                      },
                      height: 45,
                      color: selectedIndex == 1 ? MyColors.yellow : Colors.white,
                      width: double.infinity,
                      textColor: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Builder(builder: (context) {
                if (selectedIndex == 0) {
                  return buildGeneralPage();
                } else {
                  return buildNotificationsPage(notifications);
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Expanded buildNotificationsPage(List<NotificationModel> notifications) {
    return Expanded(
      child: ListView.separated(
        itemCount: notifications.length,
        separatorBuilder: (context, index) {
          return SizedBox(height: 10);
        },
        itemBuilder: (context, index) {
          NotificationModel notification = notifications[index];
          return GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: MyColors.greyLight2),
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(notification.extras.title, style: TextStyle(fontSize: 16, color: MyColors.black, fontWeight: FontWeight.w600)),
                      if (notification.extras.message != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                          child: Text(notification.extras.message!, style: TextStyle(fontSize: 14, color: MyColors.greyLight.withOpacity(0.8))),
                        ),
                    ],
                  )),
                  SizedBox(width: 10),
                  Text(notification.diffForHumans, style: TextStyle(fontSize: 12, color: MyColors.greyLight.withOpacity(0.8))),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Column buildGeneralPage() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: MyButton(
                text: 'Bugün',
                onPressed: () {},
                height: 30,
                width: double.infinity,
                borderRadius: 10,
                color: MyColors.black,
                textColor: Colors.white,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: MyButton(
                text: 'Dün',
                borderColor: MyColors.greyLight2,
                onPressed: () {},
                height: 30,
                color: Colors.white,
                borderRadius: 10,
                width: double.infinity,
                textColor: MyColors.greyLight.withOpacity(0.8),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: MyButton(
                text: '1 Hafta',
                onPressed: () {},
                height: 30,
                color: Colors.white,
                borderRadius: 10,
                width: double.infinity,
                textColor: MyColors.greyLight.withOpacity(0.8),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: MyButton(
                text: '1 Ay',
                borderColor: MyColors.greyLight2,
                onPressed: () {},
                height: 30,
                color: Colors.white,
                borderRadius: 10,
                width: double.infinity,
                textColor: MyColors.greyLight.withOpacity(0.8),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        StatisticWidget(
          title: 'Profil İncelemesi',
          value: statistics['view'].toString(),
          subtitle: 'İşletmenizi kaç kişi görüntüledi.',
          unit: 'Kişi',
        ),
        SizedBox(height: 10),
        StatisticWidget(
          title: 'Alınan Hizmetler',
          value: statistics['sale_count'].toString(),
          subtitle: 'İşletmenizden kaç kişi hizmet aldı.',
          unit: 'adet',
        ),
        SizedBox(height: 10),
        StatisticWidget(
          title: 'Toplam Satış',
          value: statistics['sale_total'].toString(),
          subtitle: 'İşletmenizin toplam kazancını gör.',
          unit: 'TL',
        ),
        SizedBox(height: 30),
        StatisticWidget(
          title: 'Aktif Ürünlerim',
          value: statistics['product_count'].toString(),
          subtitle: 'Listelemeleri görüntüle.',
          unit: 'ürün',
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProductsScreen()));
          },
        ),
      ],
    );
  }
}
