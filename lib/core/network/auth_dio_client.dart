import 'package:dio/dio.dart';
import 'package:new_development/core/network/api_intercepter.dart';

class AuthDioClient {
  late Dio dio;

  AuthDioClient()
    : dio = Dio(
        BaseOptions(
          baseUrl: "https://dummyjson.com",
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 5),
          headers: {"Content-Type": "application/json"},
        ),
      ) {
    dio.interceptors.add(ApiIntercepter(dio));
  }
}
