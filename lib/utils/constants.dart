import 'package:dio/dio.dart';

const host = 'http://192.168.15.87';
const port = '5000';
const url = '$host:$port';

final options = BaseOptions(
  baseUrl: url,
  connectTimeout: const Duration(seconds: 5),
  receiveTimeout: const Duration(seconds: 3),
);

final Dio dio = Dio(options);
