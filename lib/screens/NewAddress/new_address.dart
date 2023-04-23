import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:yolustunde_mobile/models/car_model.dart';
import 'package:yolustunde_mobile/models/dio/dio_response.dart';
import 'package:yolustunde_mobile/models/utils/brand_model.dart';
import 'package:yolustunde_mobile/models/utils/car_model_model.dart';
import 'package:yolustunde_mobile/providers/data_provider.dart';
import 'package:yolustunde_mobile/services/dio_service.dart';
import 'package:yolustunde_mobile/theme/colors.dart';
import 'package:yolustunde_mobile/utils/my_snackbar.dart';
import 'package:yolustunde_mobile/widgets/bottom_dropdown.dart';
import 'package:yolustunde_mobile/widgets/bottom_dropdown_multiple.dart';
import 'package:yolustunde_mobile/widgets/my_app_bar.dart';
import 'package:yolustunde_mobile/widgets/my_button.dart';
import 'package:yolustunde_mobile/widgets/my_textfield.dart';

class NewAddressScreen extends StatefulWidget {
  const NewAddressScreen({Key? key}) : super(key: key);

  @override
  State<NewAddressScreen> createState() => _NewAddressScreenState();
}

class _NewAddressScreenState extends State<NewAddressScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController apartController = TextEditingController();
  String type = 'home';
  List cities = [];
  int? cityId;
  List states = [];
  int? stateId;

  Future<void> create() async {
    if (titleController.text.isEmpty) {
      MySnackbar.show(context, message: 'Adres adı giriniz.');
      return;
    }
    if (descriptionController.text.isEmpty) {
      MySnackbar.show(context, message: 'Açıklama giriniz.');
      return;
    }
    if (cityId == null) {
      MySnackbar.show(context, message: 'Şehir seçiniz.');
      return;
    }
    if (stateId == null) {
      MySnackbar.show(context, message: 'İlçe seçiniz.');
      return;
    }
    if (streetController.text.isEmpty) {
      MySnackbar.show(context, message: 'Sokak giriniz.');
      return;
    }
    if (buildingController.text.isEmpty) {
      MySnackbar.show(context, message: 'Bina giriniz.');
      return;
    }
    if (floorController.text.isEmpty) {
      MySnackbar.show(context, message: 'Kat giriniz.');
      return;
    }
    if (apartController.text.isEmpty) {
      MySnackbar.show(context, message: 'Daire giriniz.');
      return;
    }

    LatLng? latLng;
    if (kDebugMode) {
      latLng = LatLng(41.015137, 28.979530);
    } else {
      Position position = await Geolocator.getCurrentPosition();
      latLng = LatLng(position.latitude, position.longitude);
    }

    DioResponse dioResponse = await DioService().request(
      'customer/addresses',
      method: Method.post,
      data: {
        'title': titleController.text,
        'address': descriptionController.text,
        'type': type,
        'city_id': cityId,
        'state_id': stateId,
        'latitude': latLng.latitude,
        'longitude': latLng.longitude,
        'apart_no': apartController.text,
        'building_no': buildingController.text,
        'floor': floorController.text,
      },
    );
    if (dioResponse.isSuccessful) {
      Navigator.pop(context, true);
      MySnackbar.show(context, message: 'Araç başarıyla eklendi.');
    } else {
      MySnackbar.show(context, message: dioResponse.message);
    }
  }

  @override
  void initState() {
    super.initState();
    checkLocation();
    getData();
    getCities();
  }

  Future<void> checkLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      // Navigator.pop(context);
      MySnackbar.show(context, message: 'Konum izni verilmedi. Lütfen ayarlardan konum iznini veriniz.');
    }
  }

  void getData() {
    DataProvider dataProvider = Provider.of<DataProvider>(context, listen: false);
    dataProvider.getBrands();
  }

  Future<void> getCities() async {
    DioResponse dioResponse = await DioService().request('parameters/cities');
    if (dioResponse.isSuccessful) {
      cities = dioResponse.data as List;
      setState(() {});
    }
  }

  void getStates() {
    DioService().request('parameters/cities/$cityId').then((dioResponse) {
      if (dioResponse.isSuccessful) {
        states = dioResponse.data as List;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: 'Araç Bilgilerim'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            MyTextfield.white(
              hintText: 'Başlık',
              controller: titleController,
            ),
            SizedBox(height: 10),
            MyTextfield.white(
              hintText: 'Açıklama',
              controller: descriptionController,
            ),
            SizedBox(height: 10),
            MyTextfield.white(
              controller: cityController,
              hintText: 'Şehir',
              readOnly: true,
              onTap: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) => BottomDropdown(
                    options: cities.map((e) => e['name']).toList(),
                    onSelected: (name) {
                      cityId = cities.where((element) => element['name'] == name).first['id'];
                      cityController.text = name;
                      getStates();
                      setState(() {});
                    },
                  ),
                );
              },
            ),
            SizedBox(height: 10),
            MyTextfield.white(
              hintText: 'İlçe',
              controller: stateController,
              readOnly: true,
              onTap: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) => BottomDropdown(
                    options: states.map((e) => e['name']).toList(),
                    onSelected: (name) {
                      stateId = states.where((element) => element['name'] == name).first['id'];
                      stateController.text = name;
                      getStates();
                      setState(() {});
                    },
                  ),
                );
              },
            ),
            SizedBox(height: 10),
            MyTextfield.white(
              hintText: 'Mahalle, Cadde, Sokak',
              controller: streetController,
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: MyTextfield.white(
                    hintText: 'Bina No',
                    controller: buildingController,
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: MyTextfield.white(
                    hintText: 'Kat',
                    controller: floorController,
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: MyTextfield.white(
                    hintText: 'Daire No',
                    controller: apartController,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        type = 'home';
                      });
                    },
                    child: Container(
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: type == 'home' ? MyColors.yellow : MyColors.greyLight2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text('Ev'),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        type = 'work';
                      });
                    },
                    child: Container(
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: type == 'work' ? MyColors.yellow : MyColors.greyLight2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text('İş'),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        type = 'other';
                      });
                    },
                    child: Container(
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: type == 'other' ? MyColors.yellow : MyColors.greyLight2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text('Diğer'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: MyButton(
            onPressed: create,
            text: 'Kaydet',
            textColor: Colors.black,
          ),
        ),
      ),
    );
  }
}
