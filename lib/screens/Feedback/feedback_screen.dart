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

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  List<CompanyTypeModel> companies = [];
  TextEditingController companyTypeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  CompanyTypeModel? selectedCompanyType;

  @override
  void initState() {
    super.initState();
    getCompanyTypes();
  }

  Future<void> getCompanyTypes() async {
    DioResponse dioResponse = await DioService().request('parameters/companytypes');
    if (dioResponse.isSuccessful) {
      companies = dioResponse.data['data'].map<CompanyTypeModel>((e) => CompanyTypeModel.fromMap(e)).toList();
      setState(() {});
    }
  }

  Future<void> sendFeedback() async {
    if (selectedCompanyType == null) {
      MySnackbar.show(context, message: 'Lütfen kategori seçiniz');
      return;
    }
    if (descriptionController.text.isEmpty) {
      MySnackbar.show(context, message: 'Lütfen açıklama giriniz');
      return;
    }
    DioResponse dioResponse = await DioService().request(
      'feedbacks',
      method: Method.post,
      data: {
        'category_id': selectedCompanyType!.id,
        'message': descriptionController.text,
      },
    );
    if (dioResponse.isSuccessful) {
      Navigator.pop(context);
      MySnackbar.show(context, message: dioResponse.data['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: 'Geri Bildirim Yap'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: MyColors.yellow.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bize öneri ve şikayetlerinizden bahsedin',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Lorem Ipsum, adı bilinmeyen bir matbaacının bir hurufat numune kitabı oluşturmak üzere bir yazı galerisini alarak karıştırdığı 1500'lerden beri endüstri standardı sahte metinler olarak kullanılmıştır. Lorem Ipsum, adı bilinmeyen bir matbaacının bir hurufat numune kitabı oluşturmak",
                      style: TextStyle(fontSize: 12, color: MyColors.grey.withOpacity(0.8), fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Kategori Seç',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              MyTextfield.white(
                controller: companyTypeController,
                hintText: 'Kategori',
                suffixIcon: Icon(Icons.keyboard_arrow_down),
                readOnly: true,
                onTap: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) => BottomDropdown(
                      options: companies.map((e) => e.title).toList(),
                      onSelected: (val) {
                        setState(() {
                          selectedCompanyType = companies.firstWhere((element) => element.title == val);
                          companyTypeController.text = val;
                        });
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              Text(
                'Bize Düşüncelerinden Bahset',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              MyTextfield.white(
                controller: descriptionController,
                hintText: 'Hangi konuda kendimizi geliştirmeliyiz veya ne kadar memnun kaldın ?',
                maxLines: 5,
              ),
              Spacer(),
              MyButton(text: 'Gönder', onPressed: sendFeedback),
            ],
          ),
        ),
      ),
    );
  }
}
