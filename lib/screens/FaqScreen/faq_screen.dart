import 'package:flutter/material.dart';
import 'package:yolustunde_mobile/models/dio/dio_response.dart';
import 'package:yolustunde_mobile/services/dio_service.dart';
import 'package:yolustunde_mobile/theme/colors.dart';
import 'package:yolustunde_mobile/widgets/my_app_bar.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  List faqs = [];

  Future<void> getFaqs() async {
    DioResponse dioResponse = await DioService().request('parameters/sss');
    if (dioResponse.isSuccessful) {
      faqs = dioResponse.data['data'];
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getFaqs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: 'Sıkça Sorulan Sorular'),
      body: SafeArea(
          bottom: false,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ListView.separated(
                itemCount: faqs.length,
                separatorBuilder: (context, index) => SizedBox(height: 16),
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(top: index == 0 ? 16 : 0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: MyColors.greyLight2),
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
                  );
                },
              ))),
    );
  }
}
