import 'package:flutter/material.dart';
import 'package:yolustunde_mobile/company_screens/NewProduct/new_product.dart';
import 'package:yolustunde_mobile/models/dio/dio_response.dart';
import 'package:yolustunde_mobile/models/product_model.dart';
import 'package:yolustunde_mobile/services/dio_service.dart';
import 'package:yolustunde_mobile/theme/colors.dart';
import 'package:yolustunde_mobile/widgets/my_app_bar.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<ProductModel> products = [];
  @override
  void initState() {
    super.initState();
    getProducts();
  }

  Future<void> getProducts() async {
    DioResponse dioResponse = await DioService().request('company/info/products');
    if (dioResponse.isSuccessful) {
      products = dioResponse.data['data'].map<ProductModel>((e) => ProductModel.fromMap(e)).toList();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: 'Listelemelerim', actions: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewProductScreen(),
              ),
            );
          },
          child: Text('Yeni Ekle', style: TextStyle(color: MyColors.yellow)),
        ),
      ]),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.separated(
          itemCount: products.length,
          separatorBuilder: (context, index) => SizedBox(height: 16),
          itemBuilder: (context, index) {
            ProductModel productModel = products[index];
            return GestureDetector(
              onTap: () {},
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0, right: 6, left: 6),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: MyColors.greyLight2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                productModel.title,
                                style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Text('Düzenle', style: TextStyle(color: MyColors.yellow, fontWeight: FontWeight.w600)),
                            ],
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '₺' + productModel.price.toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: productModel.is_active ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
