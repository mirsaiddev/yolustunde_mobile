import 'package:flutter/material.dart';
import 'package:yolustunde_mobile/models/dio/dio_response.dart';
import 'package:yolustunde_mobile/services/dio_service.dart';
import 'package:yolustunde_mobile/utils/my_snackbar.dart';
import 'package:yolustunde_mobile/widgets/my_app_bar.dart';
import 'package:yolustunde_mobile/widgets/my_button.dart';
import 'package:yolustunde_mobile/widgets/my_list_tile.dart';
import 'package:yolustunde_mobile/widgets/my_textfield.dart';

class NewProductScreen extends StatefulWidget {
  const NewProductScreen({Key? key}) : super(key: key);

  @override
  State<NewProductScreen> createState() => _NewProductScreenState();
}

class _NewProductScreenState extends State<NewProductScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  bool isActive = false;

  Future<void> create() async {
    if (titleController.text.isEmpty) {
      MySnackbar.show(context, message: 'Hizmet başlığı boş bırakılamaz');
      return;
    }
    if (descriptionController.text.isEmpty) {
      MySnackbar.show(context, message: 'Hizmet içeriği boş bırakılamaz');
      return;
    }
    if (priceController.text.isEmpty) {
      MySnackbar.show(context, message: 'Hizmet fiyatı boş bırakılamaz');
      return;
    }
    DioResponse dioResponse = await DioService().request('company/info/products', method: Method.post, data: {
      'title': titleController.text,
      'description': descriptionController.text,
      'one_time': 1,
      'minutes': 20,
      'is_active': isActive,
      'price': double.parse(priceController.text.replaceAll('.', ',')),
      'discount': 0,
    });

    print(dioResponse.data);
    if (!dioResponse.isSuccessful) {
      MySnackbar.show(context, message: dioResponse.data['message']);
      return;
    }
    Navigator.pop(context);
    MySnackbar.show(context, message: 'Hizmet başarıyla eklendi');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        title: 'Hizmet Ekle',
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hizmet Başlığı', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              MyTextfield.white(
                hintText: 'Hizmeti tanımlayan bir başlık yaz',
                controller: titleController,
              ),
              SizedBox(height: 20),
              Text('Hizmet İçeriği', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              MyTextfield.white(
                maxLines: 5,
                hintText: 'Hizmet içeriği ve detaylarını yaz.',
                controller: descriptionController,
              ),
              SizedBox(height: 20),
              Text('Hizmet Durumu', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              MyListTile(
                title: 'Aktif / Pasif',
                trailing: Switch.adaptive(
                  value: isActive,
                  onChanged: (value) {
                    setState(() {
                      isActive = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              Text('Hizmet Fiyatı', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              MyTextfield.white(
                hintText: 'Fiyat girin',
                keyboardType: TextInputType.number,
                controller: priceController,
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: MyButton(
            onPressed: create,
            text: 'Hizmet Ekle',
            textColor: Colors.black,
          ),
        ),
      ),
    );
  }
}
