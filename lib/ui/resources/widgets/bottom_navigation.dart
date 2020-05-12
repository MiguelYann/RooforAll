import 'package:custom_navigator/custom_navigator.dart';
import 'package:custom_navigator/custom_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rooforall/ui/pages/home.dart';
import 'package:rooforall/ui/pages/profile.dart';
import 'package:rooforall/ui/pages/setting.dart';
import 'package:rooforall/ui/resources/utils/utils.dart';

class BottomNavigation extends StatefulWidget {
  static const String routeName = "/bottomNavigation";
  BottomNavigation({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final primaryColor = Utils.colorFromHex("#00BFA6");

  @override
  Widget build(BuildContext context) {
    final String username = ModalRoute.of(context).settings.arguments;
    int _index = 0;
    final _items = [
      BottomNavigationBarItem(
        icon: Icon(Icons.home, color: primaryColor),
        title: Text('Accueil'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.account_circle, color: primaryColor),
        title: Text('profile'),
      ),
      BottomNavigationBarItem(
          icon: Icon(Icons.settings, color: primaryColor,), title: Text('settings')),
    ];

    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            currentIndex: _index,
            items: _items,
            onTap: (index) {
              setState(() {
                _index = index;
              });
            }));
  }
}
