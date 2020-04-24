import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class UserProvider {
  Dio _dio = Dio();
  static const DEFAULT_URL = 'http://localhost:8080';

//  Future<dynamic> logUserWithDio(String anUsername, String aPassword) async {
//    var response = await _dio.post('$DEFAULT_URL/login',
//        data: {'username': anUsername, 'password': aPassword});
//    print(response.statusCode);
//    return response;
//  }

  Future<dynamic> logUserWithHttp(String aUsername, String aPassword) async {
    try {
      var response = await http.post('$DEFAULT_URL/login',
          body: {'username': aUsername, 'password': aPassword});
      print(response.body);
      return response;
    } catch (Exception) {
      print('error');
    }
  }
}
