import 'dart:convert';
import 'package:dio/dio.dart';

class RegisterUserProvider {
  Dio _dio = Dio();
  static const DEFAULT_URL = 'http://192.168.1.52:8080';

  Future<dynamic> registerUserWithDio(String aEmail, String anUsername,
      String aPassword) async {
    var response = await _dio.post('$DEFAULT_URL/api/users/signUp',
        data: jsonEncode(
            {'email': aEmail, 'username': anUsername, 'password': aPassword}));
    print(response.statusCode);
    return response;
  }
}