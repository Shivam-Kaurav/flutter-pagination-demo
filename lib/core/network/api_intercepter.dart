import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:new_development/core/network/token_storage.dart';

class ApiIntercepter extends Interceptor {
  final Dio dio;
  bool isRefreshing = false;

  ApiIntercepter(this.dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!options.path.contains("/auth/login") &&
        TokenStorage.accessToken.isNotEmpty) {
      options.headers["Authorization"] = "Bearer ${TokenStorage.accessToken}";
    }
    debugPrint("TOKEN => ${TokenStorage.accessToken}");
    return handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    //if token expired
    if (err.response?.statusCode == 401 &&
        !err.requestOptions.path.contains('/auth/login')) {
      if (!isRefreshing) {
        isRefreshing = true;
        try {
          final response = await dio.post(
            '/auth/refresh',
            data: {
              'refreshToken': TokenStorage.refreshToken,
              'expiresInMins': 30,
            },
          );
          final newAccessToken = response.data['accessToken'];
          TokenStorage.accessToken = newAccessToken;
          isRefreshing = false;
          //retry original request
          final requestOptions = err.requestOptions;
          requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
          final retryResponse = await dio.fetch(requestOptions);
          return handler.resolve(retryResponse);
        } catch (e) {
          isRefreshing = false;

          TokenStorage.accessToken = '';
          TokenStorage.refreshToken = '';
          return handler.next(err);
        }
      }
    }

    return handler.next(err);
  }
}
