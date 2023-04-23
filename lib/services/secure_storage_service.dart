import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  FlutterSecureStorage flutterSecureStorage = const FlutterSecureStorage();
  Future<String?> get({required String key}) async {
    return await flutterSecureStorage.read(key: key);
  }

  Future<void> set({required String key, required String? value}) async {
    await flutterSecureStorage.write(key: key, value: value);
  }

  Future<void> delete({required String key}) async {
    await flutterSecureStorage.delete(key: key);
  }
}
