import 'package:flutter/material.dart';
import 'package:yolustunde_mobile/models/dio/dio_response.dart';
import 'package:yolustunde_mobile/services/dio_service.dart';
import 'package:yolustunde_mobile/utils/my_snackbar.dart';
import 'package:yolustunde_mobile/widgets/my_app_bar.dart';
import 'package:yolustunde_mobile/widgets/my_button.dart';
import 'package:yolustunde_mobile/widgets/my_textfield.dart';

class TireCheckScreen extends StatefulWidget {
  const TireCheckScreen({Key? key, required this.carId}) : super(key: key);

  final int carId;

  @override
  State<TireCheckScreen> createState() => _TireCheckScreenState();
}

class _TireCheckScreenState extends State<TireCheckScreen> {
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController startKmController = TextEditingController();
  TextEditingController endKmController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;

  TextEditingController winterStartDateController = TextEditingController();
  TextEditingController winterEndDateController = TextEditingController();
  TextEditingController winterStartKmController = TextEditingController();
  TextEditingController winterEndKmController = TextEditingController();
  DateTime? winterStartDate;
  DateTime? winterEndDate;

  Future<void> create() async {
    if (startDate != null && endDate != null && startKmController.text.isNotEmpty && endKmController.text.isNotEmpty) {
      DioResponse dioResponse = await DioService().request('customer/carinfos', method: Method.post, data: {
        'car_id': widget.carId,
        'start': startDate!.toIso8601String(),
        'end': endDate!.toIso8601String(),
        'start_km': startKmController.text,
        'end_km': endKmController.text,
        'type': 'summer_tire'
      });
    }

    if (winterStartDate != null && winterEndDate != null && winterStartKmController.text.isNotEmpty && winterEndKmController.text.isNotEmpty) {
      DioResponse dioResponse = await DioService().request('customer/carinfos', method: Method.post, data: {
        'car_id': widget.carId,
        'start': winterStartDate!.toIso8601String(),
        'end': winterEndDate!.toIso8601String(),
        'start_km': winterStartKmController.text,
        'end_km': winterEndKmController.text,
        'type': 'winter_tire'
      });
    }
    Navigator.pop(context);
    MySnackbar.show(context, message: 'Lastik Bilgileri Başarıyla Düzenlendi');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: 'Yazlık/Kışlık Lastik Takibi'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Yazlık Lastik', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: MyTextfield.white(
                      hintText: 'Başlangıç Tarihi',
                      readOnly: true,
                      controller: startDateController,
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        ).then((value) {
                          if (value != null) {
                            setState(() {
                              startDate = value;
                              startDateController.text = '${value.day}.${value.month}.${value.year}';
                            });
                          }
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: MyTextfield.white(
                      hintText: 'Bitiş Tarihi',
                      readOnly: true,
                      controller: endDateController,
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        ).then((value) {
                          if (value != null) {
                            setState(() {
                              endDate = value;
                              endDateController.text = '${value.day}.${value.month}.${value.year}';
                            });
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: MyTextfield.white(
                      hintText: 'Başlangıç Km',
                      controller: startKmController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: MyTextfield.white(
                      hintText: 'Bitiş Km',
                      controller: endKmController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text('Kışlık Lastik', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: MyTextfield.white(
                      hintText: 'Başlangıç Tarihi',
                      readOnly: true,
                      controller: winterStartDateController,
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        ).then((value) {
                          if (value != null) {
                            setState(() {
                              winterStartDate = value;
                              winterStartDateController.text = '${value.day}.${value.month}.${value.year}';
                            });
                          }
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: MyTextfield.white(
                      hintText: 'Bitiş Tarihi',
                      readOnly: true,
                      controller: winterEndDateController,
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        ).then((value) {
                          if (value != null) {
                            setState(() {
                              winterEndDate = value;
                              winterEndDateController.text = '${value.day}.${value.month}.${value.year}';
                            });
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: MyTextfield.white(
                      hintText: 'Başlangıç Km',
                      controller: winterStartKmController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: MyTextfield.white(
                      hintText: 'Bitiş Km',
                      controller: winterEndKmController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ],
          ),
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
