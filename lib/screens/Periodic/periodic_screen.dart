import 'package:flutter/material.dart';
import 'package:yolustunde_mobile/widgets/my_app_bar.dart';
import 'package:yolustunde_mobile/widgets/my_button.dart';
import 'package:yolustunde_mobile/widgets/my_textfield.dart';

class PeriodicScreen extends StatefulWidget {
  const PeriodicScreen({Key? key, required this.carId}) : super(key: key);

  final int carId;

  @override
  State<PeriodicScreen> createState() => _PeriodicScreenState();
}

class _PeriodicScreenState extends State<PeriodicScreen> {
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: 'Periyodik Bakım'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Periyodik Bakım', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: MyButton(
            onPressed: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => NewCarScreen())).then((value) {
              //   if (value != null) {
              //     getCarModels();
              //   }
              // });
            },
            text: 'Kaydet',
            textColor: Colors.black,
          ),
        ),
      ),
    );
  }
}
