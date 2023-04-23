import 'package:flutter/material.dart';
import 'package:yolustunde_mobile/models/company_model.dart';
import 'package:yolustunde_mobile/services/image_service.dart';
import 'package:yolustunde_mobile/theme/colors.dart';
import 'package:yolustunde_mobile/widgets/favorite_button.dart';
import 'package:yolustunde_mobile/widgets/my_button.dart';

import '../../screens/CompanyDetail/company_detail.dart';

class FavoriteCompanyWidget extends StatelessWidget {
  const FavoriteCompanyWidget({
    super.key,
    required this.company,
  });

  final CompanyModel company;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => CompanyDetail(id: company.id)));
      },
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: MyColors.greyLight2),
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Stack(
          children: [
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1543857182-68106299b6b2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2071&q=80',
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Padding(
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
                                company.title,
                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          width: 120,
                          child: MyButton(
                            text: 'Değerlendir',
                            textColor: Colors.black,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 12,
              right: 12,
              child: FavoriteButton(id: company.id),
            ),
          ],
        ),
      ),
    );
  }
}
