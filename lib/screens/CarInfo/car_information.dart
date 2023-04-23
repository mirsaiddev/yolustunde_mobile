import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:yolustunde_mobile/main.dart';
import 'package:yolustunde_mobile/models/car_model.dart';
import 'package:yolustunde_mobile/models/dio/dio_response.dart';
import 'package:yolustunde_mobile/screens/CarInfoDetail/car_info_detail.dart';
import 'package:yolustunde_mobile/screens/NewCar/new_car.dart';
import 'package:yolustunde_mobile/services/dio_service.dart';
import 'package:yolustunde_mobile/theme/colors.dart';
import 'package:yolustunde_mobile/utils/my_snackbar.dart';
import 'package:yolustunde_mobile/widgets/my_app_bar.dart';
import 'package:yolustunde_mobile/widgets/my_button.dart';
import 'package:yolustunde_mobile/widgets/my_list_tile.dart';

class CarInformation extends StatefulWidget {
  const CarInformation({Key? key}) : super(key: key);

  @override
  State<CarInformation> createState() => _CarInformationState();
}

class _CarInformationState extends State<CarInformation> {
  List<CarModel> carModels = [];
  bool carsGet = false;

  @override
  void initState() {
    super.initState();
    getCarModels();
  }

  Future<void> getCarModels() async {
    DioResponse dioResponse = await DioService().request('customer/cars');
    if (dioResponse.isSuccessful) {
      carModels = dioResponse.data['data'].map<CarModel>((e) => CarModel.fromMap(e)).toList();
      carsGet = true;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: 'Araç Bilgilerim'),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: MyButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => NewCarScreen())).then((value) {
                if (value != null) {
                  getCarModels();
                }
              });
            },
            text: 'Araç Ekle',
            textColor: Colors.black,
          ),
        ),
      ),
      body: Builder(builder: (context) {
        if (!carsGet) {
          return Center(child: CircularProgressIndicator.adaptive());
        }
        if (carModels.isEmpty) {
          return Center(child: Text('Araç bilginiz bulunmamaktadır.'));
        }
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.separated(
            itemCount: carModels.length,
            separatorBuilder: (context, index) {
              return SizedBox(height: 10);
            },
            itemBuilder: (context, index) {
              return MyListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CarInfoDetail(
                                carId: carModels[index].id,
                              )));
                },
                leading: Icon(Icons.car_rental),
                title: '${carModels[index].plaka} / ${carModels[index].model}',
                borderColor: MyColors.yellow,
                slidableActions: [
                  SlidableAction(
                    onPressed: (context) async {
                      DioResponse dioResponse = await DioService().request('customer/cars/${carModels[index].id}', method: Method.delete);
                      if (dioResponse.isSuccessful) {
                        MySnackbar.show(navigatorKey.currentState!.context, message: 'Araç bilginiz silindi.');
                        getCarModels();
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
