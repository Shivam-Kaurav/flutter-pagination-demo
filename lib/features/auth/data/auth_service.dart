import 'package:dio/dio.dart';
import 'package:new_development/core/network/auth_dio_client.dart';
import 'package:new_development/core/network/token_storage.dart';
import 'package:new_development/features/auth/data/auth_model.dart';

final authClient = AuthDioClient();

class AuthService {
  final Dio dio = authClient.dio;

  Future<AuthModel> login(String username, String password) async {
    try {
      final response = await dio.post(
        "/auth/login",
        data: {
          "username": username.trim(),
          "password": password.trim(),
          "expiresInMins": 30,
        },
      );

      final auth = AuthModel.fromJson(response.data);

      TokenStorage.accessToken = auth.accessToken;
      TokenStorage.refreshToken = auth.refreshToken;

      return auth;
    } on DioException catch (e) {
      rethrow;
    }
  }
}
