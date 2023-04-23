import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:yolustunde_mobile/main.dart';
import 'package:yolustunde_mobile/models/car_model.dart';
import 'package:yolustunde_mobile/models/dio/dio_response.dart';
import 'package:yolustunde_mobile/models/utils/address_model.dart';
import 'package:yolustunde_mobile/screens/NewAddress/new_address.dart';
import 'package:yolustunde_mobile/screens/NewCar/new_car.dart';
import 'package:yolustunde_mobile/services/dio_service.dart';
import 'package:yolustunde_mobile/theme/colors.dart';
import 'package:yolustunde_mobile/utils/my_snackbar.dart';
import 'package:yolustunde_mobile/widgets/my_app_bar.dart';
import 'package:yolustunde_mobile/widgets/my_button.dart';
import 'package:yolustunde_mobile/widgets/my_list_tile.dart';

class AddressInformation extends StatefulWidget {
  const AddressInformation({Key? key}) : super(key: key);

  @override
  State<AddressInformation> createState() => _AddressInformationState();
}

class _AddressInformationState extends State<AddressInformation> {
  List<AddressModel> addresses = [];
  bool addressesGet = false;

  @override
  void initState() {
    super.initState();
    getAddresses();
  }

  Future<void> getAddresses() async {
    DioResponse dioResponse = await DioService().request('customer/addresses');
    if (dioResponse.isSuccessful) {
      addresses = dioResponse.data['data'].map<AddressModel>((e) => AddressModel.fromMap(e)).toList();
      addressesGet = true;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: 'Adreslerim'),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: MyButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => NewAddressScreen())).then((value) {
                if (value != null) {
                  getAddresses();
                }
              });
            },
            text: 'Yeni Adres Ekle',
            textColor: Colors.black,
          ),
        ),
      ),
      body: Builder(builder: (context) {
        if (!addressesGet) {
          return Center(child: CircularProgressIndicator.adaptive());
        }
        if (addresses.isEmpty) {
          return Center(child: Text('Adres bilginiz bulunmamaktadır.'));
        }
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.separated(
            itemCount: addresses.length,
            separatorBuilder: (context, index) {
              return SizedBox(height: 10);
            },
            itemBuilder: (context, index) {
              AddressModel address = addresses[index];
              return MyListTile(
                leading: Icon(Icons.car_rental),
                title: (address.title),
                borderColor: MyColors.yellow,
                slidableActions: [
                  SlidableAction(
                    onPressed: (context) async {
                      DioResponse dioResponse = await DioService().request('customer/addresses/${addresses[index].id}', method: Method.delete);
                      if (dioResponse.isSuccessful) {
                        MySnackbar.show(navigatorKey.currentState!.context, message: 'Araç bilginiz silindi.');
                        getAddresses();
                      }
                    },
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete_outline,
                    label: 'Sil',
                  ),
                ],
              );
            },
          ),
        );
      }),
    );
  }
}
