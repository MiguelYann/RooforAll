import 'package:custom_navigator/custom_navigator.dart';
import 'package:custom_navigator/custom_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rooforall/ui/pages/home.dart';
import 'package:rooforall/ui/pages/profile.dart';
import 'package:rooforall/ui/pages/setting.dart';

class BottomNavigation extends StatefulWidget {

  static const String routeName = "/bottomNavigation";
  BottomNavigation({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      scaffold: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: _items,
        ),
      ),
      children: <Widget>[
        Home(),
        ProfilePage('Profile'),
        SettingPage('Setting'),
      ],
      onItemTap: (index) {},
    );
  }

  final _items = [
    BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('home')),
    BottomNavigationBarItem(
        icon: Icon(Icons.account_circle), title: Text('profile')),
    BottomNavigationBarItem(
        icon: Icon(Icons.settings), title: Text('settings')),
  ];
}
