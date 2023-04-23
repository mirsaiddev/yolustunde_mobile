import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yolustunde_mobile/models/company_type_model.dart';
import 'package:yolustunde_mobile/models/dio/dio_response.dart';
import 'package:yolustunde_mobile/services/dio_service.dart';
import 'package:yolustunde_mobile/theme/colors.dart';
import 'package:yolustunde_mobile/utils/my_snackbar.dart';
import 'package:yolustunde_mobile/widgets/bottom_dropdown.dart';
import 'package:yolustunde_mobile/widgets/my_app_bar.dart';
import 'package:yolustunde_mobile/widgets/my_button.dart';
import 'package:yolustunde_mobile/widgets/my_textfield.dart';

class NewForum extends StatefulWidget {
  const NewForum({Key? key}) : super(key: key);

  @override
  State<NewForum> createState() => _NewForumState();
}

class _NewForumState extends State<NewForum> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  String? selectedCategory;

  Future<void> sendFeedback() async {
    if (selectedCategory == null) {
      MySnackbar.show(context, message: 'Lütfen kategori seçiniz');
      return;
    }
    if (titleController.text.isEmpty) {
      MySnackbar.show(context, message: 'Lütfen başlık giriniz');
      return;
    }
    if (descriptionController.text.isEmpty) {
      MySnackbar.show(context, message: 'Lütfen açıklama giriniz');
      return;
    }

    DioResponse dioResponse = await DioService().request(
      'customer/threads',
      method: Method.post,
      data: {
        'title': titleController.text,
        'message': descriptionController.text,
        'type': selectedCategory == 'Sohbet'
            ? 'chat'
            : selectedCategory == 'Sorum Var'
                ? 'question'
                : 'journal',
      },
    );
    if (dioResponse.isSuccessful) {
      Navigator.pop(context, true);
      MySnackbar.show(context, message: dioResponse.data['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: 'Konu Aç'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                'Konu Başlığı',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              MyTextfield.white(
                controller: titleController,
                hintText: 'Başlık',
              ),
              SizedBox(height: 20),
              Text(
                'Konu İçeriği',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              MyTextfield.white(
                controller: descriptionController,
                hintText: 'Soru, görüş ve düşüncelerini yaz',
                maxLines: 5,
              ),
              SizedBox(height: 20),
              Text(
                'Kategori Seç',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              MyTextfield.white(
                controller: categoryController,
                hintText: 'Kategori',
                suffixIcon: Icon(Icons.keyboard_arrow_down),
                readOnly: true,
                onTap: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) => BottomDropdown(
                      options: ['Sohbet', 'Sorum Var', 'Gündem'].map((e) => e).toList(),
                      onSelected: (val) {
                        setState(() {
                          selectedCategory = val;
                          categoryController.text = val;
                        });
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              Spacer(),
              MyButton(text: 'Gönder', onPressed: sendFeedback),
            ],
          ),
        ),
      ),
    );
  }
}
