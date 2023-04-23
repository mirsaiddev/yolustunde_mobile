import 'package:flutter/material.dart';
import 'package:yolustunde_mobile/models/dio/dio_response.dart';
import 'package:yolustunde_mobile/models/utils/brand_model.dart';
import 'package:yolustunde_mobile/models/utils/car_model_model.dart';
import 'package:yolustunde_mobile/services/dio_service.dart';

class DataProvider extends ChangeNotifier {
  List<BrandModel> brands = [];
  List<CarModelModel> models = [];

  Future<void> getBrands() async {
    DioResponse dioResponse = await DioService().request('parameters/brands');
    if (dioResponse.isSuccessful) {
      brands = dioResponse.data['data'].map<BrandModel>((e) => BrandModel.fromMap(e)).toList();
      notifyListeners();
    }
  }

  void getModels(int id) {
    DioService().request('parameters/brands/$id').then((value) {
      if (value.isSuccessful) {
        models = value.data['data'].map<CarModelModel>((e) => CarModelModel.fromMap(e)).toList();
        notifyListeners();
      }
    });
  }
}
