import 'package:flutter/material.dart';
import 'package:yolustunde_mobile/models/dio/dio_response.dart';
import 'package:yolustunde_mobile/services/dio_service.dart';
import 'package:yolustunde_mobile/widgets/my_app_bar.dart';
import 'package:yolustunde_mobile/widgets/my_list_tile.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({Key? key}) : super(key: key);

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  @override
  void initState() {
    super.initState();
    getStatistics();
  }

  Map statistics = {};

  Future<void> getStatistics() async {
    DioResponse dioResponse = await DioService().request('company/info');
    if (dioResponse.isSuccessful) {
      setState(() {
        statistics = dioResponse.data['data'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: 'İstatistikler', showBackButton: false),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              MyListTile(
                title: 'Toplam Ürün',
                trailing: Text('${statistics['product_count']}'),
              ),
              SizedBox(height: 16),
              MyListTile(
                title: 'Toplam Satış',
                trailing: Text('${statistics['sale_count']}'),
              ),
              SizedBox(height: 16),
              MyListTile(
                title: 'Toplam Ciro',
                trailing: Text('₺${statistics['sale_total']}'),
              ),
              SizedBox(height: 16),
              MyListTile(
                title: 'Toplam Görüntülenme',
                trailing: Text('${statistics['view']}'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
