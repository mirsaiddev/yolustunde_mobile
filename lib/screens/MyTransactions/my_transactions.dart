import 'package:flutter/material.dart';
import 'package:yolustunde_mobile/services/image_service.dart';
import 'package:yolustunde_mobile/theme/colors.dart';
import 'package:yolustunde_mobile/widgets/my_app_bar.dart';

class MyTransactions extends StatefulWidget {
  const MyTransactions({Key? key}) : super(key: key);

  @override
  State<MyTransactions> createState() => _MyTransactionsState();
}

class _MyTransactionsState extends State<MyTransactions> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: 'İşlemlerim'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = 0;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: selectedIndex == 0 ? MyColors.yellow : Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: MyColors.greyLight2),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            child: Center(child: Text('Aktif')),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = 1;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: selectedIndex == 1 ? MyColors.yellow : Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: MyColors.greyLight2),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            child: Center(child: Text('Tamamlanmış')),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = 2;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: selectedIndex == 2 ? MyColors.yellow : Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: MyColors.greyLight2),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            child: Center(child: Text('Randevu')),
                          ),
                        ),
                      )
                    ],
                  )),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImageService.pngIcon('empty'),
                        height: 130,
                      ),
                      Text('Aktif işlem bulunmuyor', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600)),
                      SizedBox(height: 10),
                      Text('Hemen keşfet butonuna basarak uygulamadan hizmet almaya başlayabilirsin..',
                          textAlign: TextAlign.center, style: TextStyle(color: MyColors.greyLight.withOpacity(0.8), fontSize: 14, fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
