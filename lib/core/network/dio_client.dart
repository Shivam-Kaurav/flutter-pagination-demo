import 'package:dio/dio.dart';
import 'package:new_development/core/network/api_intercepter.dart';

class DioClient {
  late Dio dio;

  DioClient()
    : dio = Dio(
        BaseOptions(
          baseUrl: 'https://jsonplaceholder.typicode.com',
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 5),
          headers: {"Accept": "application/json"},
        ),
      ) {
    dio.interceptors.add(ApiIntercepter(dio));
  }
}
