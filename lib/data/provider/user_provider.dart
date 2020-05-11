import 'dart:convert';

import 'package:dio/dio.dart';

class UserProvider {
  Dio _dio = Dio();
  static const DEFAULT_URL = 'http://172.20.10.3:8080';

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
}
