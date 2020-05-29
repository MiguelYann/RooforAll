import 'package:flutter/material.dart';
import 'package:rooforall/ui/resources/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class View with ChangeNotifier {
  bool isView = false;

  Future<bool> get vue {
    return Future.value(isView);
  }

  View(this.isView);
  void setView(bool b)  async{
    isView = b;
    notifyListeners();
  }

  Future<bool> changeView() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (isView) {
      print("form $isView");
      notifyListeners();
      isView= sharedPreferences.getBool('seen');

      return isView;
    } else {
      sharedPreferences.setBool('seen', true);
      print("ici ${sharedPreferences.getBool('seen')}");
      isView = sharedPreferences.getBool('seen');

      notifyListeners();

      return isView;
    }
  }
}
