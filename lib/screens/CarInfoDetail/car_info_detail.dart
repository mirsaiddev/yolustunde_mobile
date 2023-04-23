import 'package:flutter/material.dart';

import 'package:yolustunde_mobile/screens/Periodic/periodic_screen.dart';
import 'package:yolustunde_mobile/screens/TireCheck/tire_check.dart';
import 'package:yolustunde_mobile/widgets/my_app_bar.dart';
import 'package:yolustunde_mobile/widgets/my_list_tile.dart';

class CarInfoDetail extends StatefulWidget {
  final int carId;
  const CarInfoDetail({
    Key? key,
    required this.carId,
  }) : super(key: key);

  @override
  State<CarInfoDetail> createState() => _CarInfoDetailState();
}

class _CarInfoDetailState extends State<CarInfoDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: 'Araç Durumu'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              MyListTile(
                title: 'Araç Periyodik Bakım',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PeriodicScreen(carId: widget.carId)));
                },
              ),
              SizedBox(height: 10),
              MyListTile(
                title: 'Yazlık / Kışlık Lastik Takibi',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TireCheckScreen(carId: widget.carId)));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
