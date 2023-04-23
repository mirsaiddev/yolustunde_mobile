import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:yolustunde_mobile/models/comment_model.dart';
import 'package:yolustunde_mobile/models/company_detail_model.dart';
import 'package:yolustunde_mobile/models/dio/dio_response.dart';
import 'package:yolustunde_mobile/models/product_model.dart';
import 'package:yolustunde_mobile/providers/bottom_nav_bar_provider.dart';
import 'package:yolustunde_mobile/screens/AddressMapScreen/address_map_screen.dart';
import 'package:yolustunde_mobile/screens/NewComment/new_comment_screen.dart';
import 'package:yolustunde_mobile/services/dio_service.dart';
import 'package:yolustunde_mobile/services/image_service.dart';
import 'package:yolustunde_mobile/theme/colors.dart';
import 'package:yolustunde_mobile/utils/my_snackbar.dart';
import 'package:yolustunde_mobile/widgets/my_app_bar.dart';
import 'package:yolustunde_mobile/widgets/my_button.dart';
import 'package:yolustunde_mobile/widgets/my_list_tile.dart';
import 'package:yolustunde_mobile/widgets/product_widget.dart';

class CompanyDetail extends StatefulWidget {
  const CompanyDetail({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  State<CompanyDetail> createState() => _CompanyDetailState();
}

class _CompanyDetailState extends State<CompanyDetail> {
  CompanyDetailModel? companyDetailModel;
  List<ProductModel> products = [];
  List<CommentModel> comments = [];
  ProductModel? selectedProduct;

  @override
  void initState() {
    super.initState();
    getDetail();
    getProducts();
    getComments();
  }

  Future<void> getDetail() async {
    DioResponse dioResponse = await DioService().request('customer/company/${widget.id}/info');
    if (dioResponse.isSuccessful) {
      setState(() {
        companyDetailModel = CompanyDetailModel.fromMap(dioResponse.data['data']);
      });
    }
  }

  Future<void> getProducts() async {
    DioResponse dioResponse = await DioService().request('customer/company/${widget.id}/products');
    if (dioResponse.isSuccessful) {
      setState(() {
        products = dioResponse.data['data'].map<ProductModel>((e) => ProductModel.fromMap(e)).toList();
      });
    }
  }

  Future<void> getComments() async {
    DioResponse dioResponse = await DioService().request('customer/company/${widget.id}/comments');
    if (dioResponse.isSuccessful) {
      setState(() {
        comments = dioResponse.data['data'].map<CommentModel>((e) => CommentModel.fromMap(e)).toList();
      });
    }
  }

  Future<void> addToCart() async {
    DioResponse dioResponse = await DioService().request(
      'customer/carts',
      method: Method.post,
      data: {
        "product_id": selectedProduct!.id,
      },
    );
    if (!dioResponse.isSuccessful) {
      MySnackbar.show(context, message: dioResponse.message);
      return;
    }
    Navigator.popUntil(context, (route) => route.isFirst);
    BottomNavBarProvider bottomNavBarProvider = Provider.of<BottomNavBarProvider>(context, listen: false);
    bottomNavBarProvider.changeIndex(2);
    MySnackbar.show(context, message: 'Ürün sepete eklendi');
    print(dioResponse.data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: buildAppBar(),
      bottomNavigationBar: selectedProduct != null
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: MyButton(
                  onPressed: addToCart,
                  text: 'Sepete Ekle',
                  textColor: Colors.black,
                ),
              ),
            )
          : null,
      body: Builder(builder: (context) {
        if (companyDetailModel == null) {
          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        return SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
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
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        for (var i = 0; i < 5; i++)
                                          Padding(
                                            padding: const EdgeInsets.only(left: 2.0),
                                            child: Image.asset(
                                              ImageService.pngIcon('star'),
                                              height: 16,
                                              color: i < companyDetailModel!.averageRating ? MyColors.yellow : MyColors.greyLight.withOpacity(0.8),
                                            ),
                                          ),
                                        SizedBox(width: 10),
                                        Text('${companyDetailModel!.averageRating} (${companyDetailModel!.countRating})',
                                            style: TextStyle(color: MyColors.grey)),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      companyDetailModel!.title.toString(),
                                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  if (products.isNotEmpty) ...[
                    ListView.separated(
                      padding: EdgeInsets.zero,
                      itemCount: products.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) => SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        ProductModel productModel = products[index];
                        return ProductWidget(
                          productModel: productModel,
                          onTap: () {
                            if (selectedProduct == (productModel)) {
                              selectedProduct = null;
                            } else {
                              selectedProduct = productModel;
                            }
                            setState(() {});
                          },
                          selected: selectedProduct == (productModel),
                        );
                      },
                    ),
                    SizedBox(height: 20),
                  ],
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: MyColors.greyLight2),
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Hizmetler', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                        GridView.builder(
                          itemCount: companyDetailModel!.services.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 4),
                          itemBuilder: (context, index) {
                            Service service = companyDetailModel!.services[index];
                            return Row(
                              children: [
                                CircleAvatar(radius: 6, backgroundColor: MyColors.yellow),
                                SizedBox(width: 10),
                                Text(service.service),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: MyColors.greyLight2),
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('İşletme Hakkında', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                        SizedBox(height: 10),
                        Text(
                          companyDetailModel!.description.toString(),
                          style: TextStyle(color: MyColors.grey.withOpacity(0.8)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  MyListTile(
                    title: 'Adres',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddressMapScreen(latLng: LatLng(companyDetailModel!.latitude, companyDetailModel!.longitude))));
                    },
                  ),
                  SizedBox(height: 20),
                  if (comments.isNotEmpty) ...[
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: MyColors.greyLight2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Geri Bildirimler / ${companyDetailModel!.averageRating}',
                                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                                      ),
                                      SizedBox(width: 6),
                                      Image.asset(ImageService.pngIcon('star'), height: 16),
                                      SizedBox(width: 6),
                                      Text('( ${companyDetailModel!.countRating})',
                                          style: TextStyle(color: MyColors.greyLight.withOpacity(0.6), fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => NewCommentScreen(companyDetailModel: companyDetailModel!)));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: MyColors.yellow,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                      ),
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 14),
                                    child: Text('Geri Bildirim Ver', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 12)),
                                  ),
                                ),
                              ],
                            ),
                            ListView.separated(
                              padding: EdgeInsets.zero,
                              itemCount: comments.length > 3 ? 3 : comments.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) => SizedBox(height: 10),
                              itemBuilder: (context, index) {
                                CommentModel commentModel = comments[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  child: Row(
                                    children: [
                                      CircleAvatar(radius: 22),
                                      SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              commentModel.full_name,
                                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black),
                                            ),
                                            SizedBox(height: 4),
                                            Row(
                                              children: [
                                                Text(commentModel.rating.toString(), style: TextStyle(color: MyColors.black)),
                                                SizedBox(width: 4),
                                                for (var i = 0; i < 5; i++)
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 2.0),
                                                    child: Image.asset(
                                                      ImageService.pngIcon('star'),
                                                      height: 16,
                                                      color: i < commentModel.rating ? MyColors.yellow : MyColors.greyLight.withOpacity(0.8),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              commentModel.comment,
                                              style: TextStyle(color: MyColors.greyLight.withOpacity(0.8)),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 10),
                            Center(
                              child: Text(
                                'Tümünü Gör',
                                style: TextStyle(color: MyColors.yellow, fontWeight: FontWeight.w600, fontSize: 14),
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
