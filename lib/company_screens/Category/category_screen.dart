import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yolustunde_mobile/company_screens/CCompanyDetail/c_company_detail.dart';
import 'package:yolustunde_mobile/models/user/user_model.dart';
import 'package:yolustunde_mobile/providers/user_provider.dart';
import 'package:yolustunde_mobile/services/image_service.dart';
import 'package:yolustunde_mobile/widgets/my_app_bar.dart';
import 'package:yolustunde_mobile/widgets/my_list_tile.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    UserModel user = userProvider.userModel!;
    return Scaffold(
      appBar: buildAppBar(title: 'Kategori'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              MyListTile(
                leading: Image.asset(
                  ImageService.pngIcon('shop'),
                  height: 24,
                ),
                title: 'İşletmem',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CCompanyDetail(id: user.company!.id)));
                },
              ),
              SizedBox(height: 16),
              MyListTile(
                leading: Image.asset(
                  ImageService.pngIcon('task-square'),
                  height: 24,
                ),
                title: 'Listelemelerim',
                onTap: () {},
              ),
              SizedBox(height: 16),
              MyListTile(
                leading: Image.asset(
                  ImageService.pngIcon('star_outlined'),
                  height: 24,
                ),
                title: 'Geri Bildirimler',
                onTap: () {},
              ),
              SizedBox(height: 16),
              MyListTile(
                leading: Image.asset(
                  ImageService.pngIcon('personal'),
                  height: 24,
                ),
                title: 'Finans',
                onTap: () {},
              ),
              SizedBox(height: 16),
              MyListTile(
                leading: Image.asset(
                  ImageService.pngIcon('sms'),
                  height: 24,
                ),
                title: 'Bize Geri Dönüş Yap',
                onTap: () {},
              ),
              SizedBox(height: 16),
              MyListTile(
                leading: Image.asset(
                  ImageService.pngIcon('medal-star'),
                  height: 24,
                ),
                title: 'Reklam ve Kampanyalar',
                onTap: () {},
              ),
              SizedBox(height: 16),
              MyListTile(
                leading: Image.asset(
                  ImageService.pngIcon('settings'),
                  height: 24,
                ),
                title: 'Ayarlar',
                onTap: () {},
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
