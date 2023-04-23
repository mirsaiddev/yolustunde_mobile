import 'package:flutter/material.dart';
import 'package:yolustunde_mobile/main.dart';
import 'package:yolustunde_mobile/models/company_model.dart';
import 'package:yolustunde_mobile/models/dio/dio_response.dart';
import 'package:yolustunde_mobile/models/notification_model.dart';
import 'package:yolustunde_mobile/models/user/user_model.dart';
import 'package:yolustunde_mobile/screens/Splash/splash.dart';
import 'package:yolustunde_mobile/services/dio_service.dart';
import 'package:yolustunde_mobile/services/secure_storage_service.dart';

class UserProvider extends ChangeNotifier {
  UserModel? userModel;
  List<CompanyModel> favoriteCompanies = [];
  List<NotificationModel> notifications = [];

  Future<void> getUser() async {
    DioResponse dioResponse = await DioService().request('me');

    if (dioResponse.isSuccessful) {
      userModel = UserModel.fromMap(dioResponse.data['data']);
      print(userModel.toString());
      notifyListeners();
    }
  }

  Future<void> getFavorites() async {
    DioResponse dioResponse = await DioService().request('customer/favorites');
    if (dioResponse.isSuccessful) {
      favoriteCompanies = (dioResponse.data['data'] as List).map((e) => CompanyModel.fromMap(e)).toList();
      notifyListeners();
    }
  }

  Future<void> addFavorites(int id) async {
    DioResponse dioResponse = await DioService().request('customer/favorites', method: Method.post, data: {
      'company_id': id,
    });
    if (dioResponse.isSuccessful) {
      getFavorites();
    }
  }

  Future<void> getNotifications() async {
    DioResponse dioResponse = await DioService().request('notifications');
    if (dioResponse.isSuccessful) {
      notifications = (dioResponse.data['data'] as List).map((e) => NotificationModel.fromMap(e)).toList();
      notifyListeners();
    }
  }

  Future<void> logout() async {
    userModel = null;
    favoriteCompanies = [];
    notifications = [];
    await SecureStorageService().delete(key: 'token');
    Navigator.pushAndRemoveUntil(
      navigatorKey.currentState!.context,
      MaterialPageRoute(builder: (context) => SplashScreen()),
      (route) => false,
    );
    notifyListeners();
  }
}
