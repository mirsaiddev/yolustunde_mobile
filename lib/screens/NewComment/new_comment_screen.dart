import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:yolustunde_mobile/models/company_detail_model.dart';
import 'package:yolustunde_mobile/models/dio/dio_response.dart';
import 'package:yolustunde_mobile/services/dio_service.dart';
import 'package:yolustunde_mobile/services/image_service.dart';
import 'package:yolustunde_mobile/theme/colors.dart';
import 'package:yolustunde_mobile/utils/my_snackbar.dart';
import 'package:yolustunde_mobile/widgets/my_app_bar.dart';
import 'package:yolustunde_mobile/widgets/my_button.dart';
import 'package:yolustunde_mobile/widgets/my_list_tile.dart';
import 'package:yolustunde_mobile/widgets/my_textfield.dart';

class NewCommentScreen extends StatefulWidget {
  const NewCommentScreen({Key? key, required this.companyDetailModel}) : super(key: key);

  final CompanyDetailModel companyDetailModel;

  @override
  State<NewCommentScreen> createState() => _NewCommentScreenState();
}

class _NewCommentScreenState extends State<NewCommentScreen> {
  TextEditingController commentController = TextEditingController();
  int? rating;

  Future<void> comment() async {
    if (commentController.text.isEmpty) {
      MySnackbar.show(context, message: 'Yorum alanı boş bırakılamaz');
      return;
    }
    if (rating == null) {
      MySnackbar.show(context, message: 'Değerlendirme yapmadınız');
      return;
    }
    DioResponse dioResponse = await DioService().request('customer/comments', method: Method.post, data: {
      'company_id': widget.companyDetailModel.id,
      'comment': commentController.text,
      'rating': rating,
    });
    Navigator.pop(context);
    MySnackbar.show(context, message: 'Yorumunuz başarıyla gönderildi');
  }

  @override
  Widget build(BuildContext context) {
    CompanyDetailModel companyDetailModel = widget.companyDetailModel;
    return Scaffold(
      appBar: buildAppBar(title: 'Geri Bildirim Ver'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: MyColors.greyLight2),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1543857182-68106299b6b2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2071&q=80',
                        height: 160,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Text(
                            companyDetailModel.title.toString(),
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              MyListTile(
                title: 'Değerlendir',
                trailing: RatingStars(
                  maxValueVisibility: false,
                  valueLabelVisibility: false,
                  value: rating?.toDouble() ?? 0,
                  starBuilder: (index, color) => Image.asset(ImageService.pngIcon('star'), height: 16, color: color),
                  starColor: MyColors.yellow,
                  onValueChanged: (value) {
                    setState(() {
                      rating = value.toInt();
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              Text('Yorum Yaz', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              MyTextfield.white(
                maxLines: 5,
                controller: commentController,
                hintText: 'İşletme hakkında bir şeyler yaz',
                maxLength: 150,
                showCounterText: true,
                // controller: descriptionController,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: MyButton(
            onPressed: comment,
            text: 'Değerlendir',
            textColor: Colors.black,
          ),
        ),
      ),
    );
  }
}
