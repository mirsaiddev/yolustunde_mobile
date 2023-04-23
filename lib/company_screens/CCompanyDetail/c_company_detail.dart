import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yolustunde_mobile/models/company_detail_model.dart';
import 'package:yolustunde_mobile/models/dio/dio_response.dart';
import 'package:yolustunde_mobile/screens/AddressMapScreen/address_map_screen.dart';
import 'package:yolustunde_mobile/services/dio_service.dart';
import 'package:yolustunde_mobile/services/image_service.dart';
import 'package:yolustunde_mobile/theme/colors.dart';
import 'package:yolustunde_mobile/widgets/my_app_bar.dart';
import 'package:yolustunde_mobile/widgets/my_list_tile.dart';

class CCompanyDetail extends StatefulWidget {
  const CCompanyDetail({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  State<CCompanyDetail> createState() => _CCompanyDetailState();
}

class _CCompanyDetailState extends State<CCompanyDetail> {
  CompanyDetailModel? companyDetailModel;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    DioResponse dioResponse = await DioService().request('customer/company/${widget.id}/info');
    if (dioResponse.isSuccessful) {
      setState(() {
        companyDetailModel = CompanyDetailModel.fromMap(dioResponse.data['data']);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Builder(builder: (context) {
        if (companyDetailModel == null) {
          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        return SafeArea(
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
                                          ),
                                        ),
                                      SizedBox(width: 10),
                                      Text('4.6 (123)', style: TextStyle(color: MyColors.grey)),
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
                SizedBox(height: 10),
                MyListTile(
                  title: 'Adres',
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddressMapScreen(latLng: LatLng(companyDetailModel!.latitude, companyDetailModel!.longitude))));
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
