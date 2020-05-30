import 'package:flutter/material.dart';

class ThemeNotif with ChangeNotifier {
  ThemeData _themeData;

  ThemeNotif(this._themeData);
  getTheme() => _themeData;

  setTheme(ThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();
  }
}