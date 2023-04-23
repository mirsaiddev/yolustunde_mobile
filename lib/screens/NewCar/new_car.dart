import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yolustunde_mobile/models/car_model.dart';
import 'package:yolustunde_mobile/models/dio/dio_response.dart';
import 'package:yolustunde_mobile/models/utils/brand_model.dart';
import 'package:yolustunde_mobile/models/utils/car_model_model.dart';
import 'package:yolustunde_mobile/providers/data_provider.dart';
import 'package:yolustunde_mobile/services/dio_service.dart';
import 'package:yolustunde_mobile/utils/my_snackbar.dart';
import 'package:yolustunde_mobile/widgets/bottom_dropdown.dart';
import 'package:yolustunde_mobile/widgets/bottom_dropdown_multiple.dart';
import 'package:yolustunde_mobile/widgets/my_app_bar.dart';
import 'package:yolustunde_mobile/widgets/my_button.dart';
import 'package:yolustunde_mobile/widgets/my_textfield.dart';

class NewCarScreen extends StatefulWidget {
  const NewCarScreen({Key? key}) : super(key: key);

  @override
  State<NewCarScreen> createState() => _NewCarScreenState();
}

class _NewCarScreenState extends State<NewCarScreen> {
  TextEditingController plaka1Controller = TextEditingController();
  TextEditingController plaka2Controller = TextEditingController();
  TextEditingController plaka3Controller = TextEditingController();

  BrandModel? selectedBrand;
  TextEditingController brandController = TextEditingController();

  CarModelModel? selectedModel;
  TextEditingController modelController = TextEditingController();

  int? year;
  TextEditingController yearController = TextEditingController();

  Map selectedColor = {};
  TextEditingController colorController = TextEditingController();

  Future<void> create() async {
    if (plaka1Controller.text.isEmpty || plaka2Controller.text.isEmpty || plaka3Controller.text.isEmpty) {
      MySnackbar.show(context, message: 'Lütfen plaka alanlarını doldurunuz.');
      return;
    }
    if (selectedBrand == null) {
      MySnackbar.show(context, message: 'Lütfen marka seçiniz.');
      return;
    }
    if (selectedModel == null) {
      MySnackbar.show(context, message: 'Lütfen model seçiniz.');
      return;
    }
    if (year == null) {
      MySnackbar.show(context, message: 'Lütfen üretim yılı seçiniz.');
      return;
    }
    // if (selectedColor.isEmpty) {
    //   MySnackbar.show(context, message: 'Lütfen renk seçiniz.');
    //   return;
    // }

    DioResponse dioResponse = await DioService().request(
      'customer/cars',
      method: Method.post,
      data: {
        'model_id': selectedModel!.id,
        'plaka': '${plaka1Controller.text} ${plaka2Controller.text} ${plaka3Controller.text}',
        'color': 'red', //! değişecek color parametresi gelince
        'year': year,
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
    getData();
  }

  void getData() {
    DataProvider dataProvider = Provider.of<DataProvider>(context, listen: false);
    dataProvider.getBrands();
  }

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    List<BrandModel> brands = dataProvider.brands;
    List<CarModelModel> models = dataProvider.models;
    return Scaffold(
      appBar: buildAppBar(title: 'Araç Bilgilerim'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: MyTextfield.white(
                    controller: plaka1Controller,
                    hintText: 'Plaka',
                    keyboardType: TextInputType.number,
                    maxLength: 2,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: MyTextfield.white(
                    controller: plaka2Controller,
                    hintText: '***',
                    keyboardType: TextInputType.text,
                    maxLength: 3,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: MyTextfield.white(
                    controller: plaka3Controller,
                    hintText: '***',
                    keyboardType: TextInputType.number,
                    maxLength: 3,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            MyTextfield.white(
              controller: brandController,
              hintText: 'Marka',
              suffixIcon: Icon(Icons.keyboard_arrow_down),
              readOnly: true,
              onTap: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) => BottomDropdown(
                    options: brands.map((e) => e.name).toList(),
                    onSelected: (val) {
                      setState(() {
                        selectedBrand = brands.firstWhere((element) => element.name == val);
                        brandController.text = val;
                        dataProvider.getModels(selectedBrand!.id);
                      });
                    },
                  ),
                );
              },
            ),
            SizedBox(height: 10),
            MyTextfield.white(
              controller: modelController,
              hintText: 'Model',
              suffixIcon: Icon(Icons.keyboard_arrow_down),
              onTap: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) => BottomDropdown(
                    options: models.map((e) => e.name).toList(),
                    onSelected: (val) {
                      setState(() {
                        selectedModel = models.firstWhere((element) => element.name == val);
                        modelController.text = val;
                      });
                    },
                  ),
                );
              },
            ),
            SizedBox(height: 10),
            MyTextfield.white(
              controller: yearController,
              hintText: 'Yıl',
              suffixIcon: Icon(Icons.keyboard_arrow_down),
              onTap: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) => BottomDropdown(
                    options: List.generate(100, (index) => DateTime.now().year - index).map((e) => e.toString()).toList(),
                    onSelected: (val) {
                      setState(() {
                        year = int.parse(val);
                        yearController.text = val;
                      });
                    },
                  ),
                );
              },
            ),
            SizedBox(height: 10),
            MyTextfield.white(
              controller: colorController,
              hintText: 'Renk',
              suffixIcon: Icon(Icons.keyboard_arrow_down),
            ),
            SizedBox(height: 10),
            MyButton(
              text: 'Oluştur',
              onPressed: create,
            ),
          ],
        ),
      ),
    );
  }
}
