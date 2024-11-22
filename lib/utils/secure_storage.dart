import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const secureStorage = FlutterSecureStorage();

Future<void> storeAccessToken(String token) async {
  await secureStorage.write(key: 'jwt_access_token', value: token);
}

Future<String?> getAccessToken() async {
  return await secureStorage.read(key: 'jwt_access_token');
}

Future<void> deleteAccessToken() async {
  await secureStorage.delete(key: 'jwt_access_token');
}
