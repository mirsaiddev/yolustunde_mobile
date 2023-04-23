import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yolustunde_mobile/models/dio/dio_response.dart';
import 'package:yolustunde_mobile/models/user/user_model.dart';
import 'package:yolustunde_mobile/providers/user_provider.dart';
import 'package:yolustunde_mobile/screens/AddressInformation/address_information.dart';
import 'package:yolustunde_mobile/screens/CarInfo/car_information.dart';
import 'package:yolustunde_mobile/screens/CarInfoDetail/car_info_detail.dart';
import 'package:yolustunde_mobile/screens/ChangePassword/change_password.dart';
import 'package:yolustunde_mobile/services/dio_service.dart';
import 'package:yolustunde_mobile/services/image_service.dart';
import 'package:yolustunde_mobile/theme/colors.dart';
import 'package:yolustunde_mobile/utils/extensions/gender_enum.dart';
import 'package:yolustunde_mobile/utils/my_snackbar.dart';
import 'package:yolustunde_mobile/widgets/bottom_dropdown.dart';
import 'package:yolustunde_mobile/widgets/my_app_bar.dart';
import 'package:yolustunde_mobile/widgets/my_button.dart';
import 'package:yolustunde_mobile/widgets/my_list_tile.dart';
import 'package:yolustunde_mobile/widgets/my_profile_image_widget.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  void initState() {
    super.initState();
    setProfile();
  }

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  Gender? gender;
  TextEditingController aboutController = TextEditingController();

  bool profileSet = false;

  Future<void> setProfile() async {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    await userProvider.getUser();
    UserModel user = userProvider.userModel!;
    firstNameController.text = user.firstName;
    lastNameController.text = user.lastName;
    phoneController.text = user.phone;
    emailController.text = user.email;
    aboutController.text = user.about ?? '';
    gender = user.gender;
    setState(() {
      profileSet = true;
    });
  }

  Future<void> update() async {
    Map data = {
      'first_name': firstNameController.text,
      'last_name': lastNameController.text,
      'phone': phoneController.text,
      'email': emailController.text,
      'gender': gender != null ? gender?.name : null,
      'about': aboutController.text,
    };

    DioResponse dioResponse = await DioService().request('profile', method: Method.post, data: data);
    MySnackbar.show(context, message: dioResponse.data['message']);
    setProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: 'Profili Düzenle'),
      body: Builder(builder: (context) {
        if (!profileSet) {
          return Center(child: CircularProgressIndicator.adaptive());
        }
        return SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        MyProfileImageWidget(
                          height: 100,
                          width: 100,
                          border: true,
                          radius: 100,
                          borderColor: Colors.white,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Icon(
                              Icons.camera_alt_outlined,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Kişisel Bilgilerim',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 16),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: MyColors.greyLight2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    child: Row(
                      children: [
                        Text('Ad', style: TextStyle(color: MyColors.greyLight.withOpacity(0.8), fontSize: 14, fontWeight: FontWeight.w600)),
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: Center(
                              child: Container(
                                // color: Colors.red,
                                child: TextFormField(
                                  controller: firstNameController,
                                  textAlign: TextAlign.end,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                    border: InputBorder.none,
                                    hintText: 'Giriniz',
                                    hintStyle: TextStyle(color: MyColors.greyLight.withOpacity(0.8), fontSize: 14, fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: MyColors.greyLight2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    child: Row(
                      children: [
                        Text('Soyad', style: TextStyle(color: MyColors.greyLight.withOpacity(0.8), fontSize: 14, fontWeight: FontWeight.w600)),
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: Center(
                              child: Container(
                                // color: Colors.red,
                                child: TextFormField(
                                  controller: lastNameController,
                                  textAlign: TextAlign.end,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                    border: InputBorder.none,
                                    hintText: 'Giriniz',
                                    hintStyle: TextStyle(color: MyColors.greyLight.withOpacity(0.8), fontSize: 14, fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: MyColors.greyLight2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    child: Row(
                      children: [
                        Text('Telefon Numarası', style: TextStyle(color: MyColors.greyLight.withOpacity(0.8), fontSize: 14, fontWeight: FontWeight.w600)),
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: Center(
                              child: Container(
                                // color: Colors.red,
                                child: TextFormField(
                                  controller: phoneController,
                                  readOnly: true,
                                  textAlign: TextAlign.end,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                    border: InputBorder.none,
                                    hintText: 'Giriniz',
                                    hintStyle: TextStyle(color: MyColors.greyLight.withOpacity(0.8), fontSize: 14, fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: MyColors.greyLight2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    child: Row(
                      children: [
                        Text('Mail Adresi', style: TextStyle(color: MyColors.greyLight.withOpacity(0.8), fontSize: 14, fontWeight: FontWeight.w600)),
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: Center(
                              child: Container(
                                // color: Colors.red,
                                child: TextFormField(
                                  controller: emailController,
                                  textAlign: TextAlign.end,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                    border: InputBorder.none,
                                    hintText: 'Giriniz',
                                    hintStyle: TextStyle(color: MyColors.greyLight.withOpacity(0.8), fontSize: 14, fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (context) => BottomDropdown(
                          options: ['Erkek', 'Kadın'],
                          onSelected: (val) {
                            if (val == 'Erkek') {
                              gender = Gender.male;
                            } else {
                              gender = Gender.female;
                            }
                            setState(() {});
                          },
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: MyColors.greyLight2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      child: Row(
                        children: [
                          Text('Cinsiyet', style: TextStyle(color: MyColors.greyLight.withOpacity(0.8), fontSize: 14, fontWeight: FontWeight.w600)),
                          Expanded(
                            child: SizedBox(
                                height: 50,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      gender?.toName() ?? 'Seçiniz',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: MyColors.greyLight2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Hakkımda', style: TextStyle(color: MyColors.greyLight.withOpacity(0.8), fontSize: 14, fontWeight: FontWeight.w600)),
                          SizedBox(
                            child: Center(
                              child: Container(
                                child: TextFormField(
                                  controller: aboutController,
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Giriniz',
                                    hintStyle: TextStyle(color: MyColors.greyLight.withOpacity(0.8), fontSize: 14, fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  MyButton(
                    text: 'Güncelle',
                    color: MyColors.black,
                    textColor: Colors.white,
                    onPressed: update,
                  ),
                  SizedBox(height: 40),
                  MyListTile(
                    title: 'Adreslerim',
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddressInformation()));
                    },
                  ),
                  SizedBox(height: 10),
                  MyListTile(
                    title: 'Araç Bilgilerim',
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CarInformation()));
                    },
                  ),
                  SizedBox(height: 10),
                  MyListTile(
                    title: 'Şifre Değiştir',
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePassword()));
                    },
                  ),
                  SizedBox(height: 10),
                  MyListTile(
                    title: 'Telefon Numarası',
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddressInformation()));
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
