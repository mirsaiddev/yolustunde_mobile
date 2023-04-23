import 'package:flutter/material.dart';
import 'package:yolustunde_mobile/models/dio/dio_response.dart';
import 'package:yolustunde_mobile/providers/cart_data_model.dart';
import 'package:yolustunde_mobile/services/dio_service.dart';

class CartProvider extends ChangeNotifier {
  CartDataModel? cartDataModel;
  Future<void> getCart() async {
    DioResponse dioResponse = await DioService().request('customer/carts');
    print(dioResponse.data);
    if (dioResponse.isSuccessful) {
      cartDataModel = CartDataModel.fromMap(dioResponse.data['data']);
      print(cartDataModel.toString());
      notifyListeners();
    }
  }
}
