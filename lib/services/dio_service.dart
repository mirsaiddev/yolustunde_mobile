import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:yolustunde_mobile/main.dart';
import 'package:yolustunde_mobile/models/dio/dio_response.dart';
import 'package:yolustunde_mobile/screens/Splash/splash.dart';
import 'package:yolustunde_mobile/services/secure_storage_service.dart';
import 'package:yolustunde_mobile/utils/my_snackbar.dart';

enum Method { get, post, put, delete }

class DioService {
  static final DioService _singleton = DioService._internal();

  factory DioService() {
    return _singleton;
  }

  DioService._internal() {
    init();
  }

  Dio _dio = Dio();
  Future<void> init() async {
    Map<String, dynamic> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    String? token = await SecureStorageService().get(key: 'token');
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
      headers.addAll({'Accept': 'application/json'});
    }
    _dio.options.baseUrl = 'https://yolustunde.com/api/v1/';
    _dio.options.headers = headers;
  }

  Future<DioResponse> request(
    String path, {
    Method method = Method.get,
    Options? options,
    void Function(int, int)? onReceiveProgress,
    void Function(int, int)? onSendProgress,
    Map<String, dynamic>? queryParameters,
    Object? data,
  }) async {
    try {
      Response response;
      switch (method) {
        case Method.get:
          response = await _dio.get(
            path,
            // options: options,
            data: data,
            queryParameters: queryParameters,
            onReceiveProgress: onReceiveProgress,
          );
          break;

        case Method.post:
          response = await _dio.post(
            path,
            // options: options,
            data: data,
            queryParameters: queryParameters,
            onReceiveProgress: onReceiveProgress,
            onSendProgress: onSendProgress,
          );
          break;

        case Method.put:
          response = await _dio.put(
            path,
            options: options,
            data: data,
            queryParameters: queryParameters,
            onReceiveProgress: onReceiveProgress,
            onSendProgress: onSendProgress,
          );
          break;

        case Method.delete:
          response = await _dio.delete(
            path,
            options: options,
            data: data,
            queryParameters: queryParameters,
          );
          break;

        default:
          response = await _dio.get(
            path,
            options: options,
            data: data,
            queryParameters: queryParameters,
            onReceiveProgress: onReceiveProgress,
          );
          break;
      }

      // debugPrint(response.data.toString());

      return DioResponse(
        data: response.data.runtimeType == String ? jsonDecode(response.data) : response.data,
        isSuccessful: true,
        statusCode: response.statusCode ?? 0,
        message: 'Success',
      );
    } on SocketException catch (e) {
      return DioResponse(data: {}, isSuccessful: false, statusCode: 0, message: 'SocketException: ${e.message}');
    } on DioError catch (e) {
      debugPrint('ERROR OCCURED IN $path, MESSAGE IS: ${e.message}, RESPONSE IS: ${e.response?.data}');
      if (e.response != null) {
        if (e.response?.data != null && e.response?.data.isNotEmpty) {
          if (e.response?.data['message'] == 'Unauthenticated.' && path != 'login') {
            await SecureStorageService().delete(key: 'token');
            Navigator.pushAndRemoveUntil(navigatorKey.currentState!.context, MaterialPageRoute(builder: (context) => SplashScreen()), (route) => false);
            MySnackbar.show(navigatorKey.currentState!.context, message: 'Oturumunuz sonlandırıldı. Lütfen tekrar giriş yapın.');
          }
        }
      }
      return DioResponse(
        data: e.response != null ? e.response!.data : {},
        isSuccessful: false,
        statusCode: e.response?.statusCode ?? 0,
        message: e.response != null ? (e.response!.data['message'] != null ? e.response!.data['message'] : e.message) : e.message,
      );
    } on Exception catch (e) {
      return DioResponse(data: {}, isSuccessful: false, statusCode: 0, message: 'Exception: ${e.toString()}');
    }
  }
}
