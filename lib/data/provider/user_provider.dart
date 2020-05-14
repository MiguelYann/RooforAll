import 'dart:convert';

import 'package:dio/dio.dart';

class UserProvider {
  Dio _dio = Dio();
  static const DEFAULT_URL = 'http://192.168.1.52:8080';

  Future<dynamic> logUser(String anUsername, String aPassword) async {
    var response = await _dio.post('$DEFAULT_URL/login',
        data: jsonEncode({'username': anUsername, 'password': aPassword}));
    return response;
  }

  Future<dynamic> registerUser(
      String aEmail, String anUsername, String aPassword) async {
    var response = await _dio.post('$DEFAULT_URL/api/users/signUp',
        data: jsonEncode(
            {'email': aEmail, 'username': anUsername, 'password': aPassword}));
    return response;
  }

  Future<dynamic> getUserInformation(String aBearerToken) async {
    return await _dio.get('$DEFAULT_URL/api/users/getInfo',
        options: Options(headers: {"authorization": aBearerToken}));
  }
}
