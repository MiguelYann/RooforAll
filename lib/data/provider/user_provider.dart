import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  static const DEFAULT_URL =
      'https://rooforall-1590500604408.azurewebsites.net';

  String _userName;
  String _token;
  bool isLogged = false;
  String _ville;
  List<dynamic> _records;
  SharedPreferences _sharedPreferences;

  UserProvider( this._token);
bool seen = false;

bool get logged {
  return isLogged;
}
  String get username {
    return _userName;
  }

  String get ville {
    return _ville;
  }

  String get token {
    return _token;
  }

  List<dynamic> get records {
    return _records;
  }

  Dio _dio = Dio();

  Future<dynamic> logUser(String anUsername, String aPassword) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    var response = await _dio.post(
      '$DEFAULT_URL/login',
      data: jsonEncode({
        'username': anUsername,
        'password': aPassword,
      }),
    );
    _userName = response.data["username"];
    print(response.data["username"]);
    _token = response.headers.value("authorization").substring(7);
    _sharedPreferences.setString("token", _token);
    _token = _sharedPreferences.get("token");
    notifyListeners();
    return response;
  }

  Future<dynamic> registerUser(
      String aEmail, String anUsername, String aPassword) async {
    var response = await _dio.post('$DEFAULT_URL/api/users/signUp',
        data: jsonEncode(
            {'email': aEmail, 'username': anUsername, 'password': aPassword}));
    return response;
  }

  Future<dynamic> getUserInformation() async {
    final response = await _dio.get('$DEFAULT_URL/api/users/getInfo',
        options: Options(
          headers: {"Authorization": 'Bearer $_token'},
        ));
    _userName = response.data["username"];
    _records = response.data["records"];
    return _records;
  }
}
