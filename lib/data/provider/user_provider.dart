import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  static const DEFAULT_URL =
      'https://rooforall-1590500604408.azurewebsites.net';

  String _userName;
  String _userMail;
  String _userPassword;
  String _token;
  bool isLogged = false;
  String _ville;
  List<dynamic> _records;
  bool seen = false;
  int totalRecords = 0;

  UserProvider(this._token);

  bool get logged {
    return isLogged;
  }

  String get username {
    return _userName;
  }

  String get userMail {
    return _userMail;
  }

  String get userPassword {
    return _userPassword;
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
  SharedPreferences _sharedPreferences;

  Future<dynamic> logUser(String anUsername, String aPassword) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    var response = await _dio.post(
      '$DEFAULT_URL/login',
      data: jsonEncode({
        'username': anUsername,
        'password': aPassword,
      }),
    );
    _userPassword = aPassword;
    _sharedPreferences.setString("userPassword", _userPassword);
    _userName = response.data["username"];
    print(response.data["username"]);
    _token = response.headers.value("authorization").substring(7);
    _sharedPreferences.setString("token", _token);
    _token = _sharedPreferences.get("token");
//    print(_token);
    notifyListeners();
    return response;
  }

  Future<dynamic> registerUser(
      String aEmail, String anUsername, String aPassword) async {
    _sharedPreferences = await SharedPreferences.getInstance();

    _sharedPreferences = await SharedPreferences.getInstance();
    var response = await _dio.post('$DEFAULT_URL/api/users/signUp',
        data: jsonEncode(
            {'email': aEmail, 'username': anUsername, 'password': aPassword}));
    return response;
  }

  Future<dynamic> getUserInformation() async {
    _sharedPreferences = await SharedPreferences.getInstance();

    print("GET INFO");
    final response = await _dio.get('$DEFAULT_URL/api/users/getInfo',
        options: Options(
          headers: {"Authorization": 'Bearer $_token'},
        ));
    print("RESPONSE ${response.statusCode}");
    _userName = response.data["username"];
    _userMail = response.data["email"];
    print("USERMAIL $_userMail");
    _sharedPreferences.setString("username", _userName);
    _sharedPreferences.setString("userMail", _userMail);

    _records = response.data["records"];
    totalRecords = _records.length;
    print(_records);
    return _records;
  }

  void logOut() {
    _sharedPreferences.remove("token");
    _token = null;
    print("Logout");
    notifyListeners();
  }
}
