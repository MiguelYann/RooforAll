import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rooforall/data/provider/picture_provider.dart';
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
  int _currentIndex = 0;

  var _items = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home, color: Utils.customGreenColor),
      title: Text('Accueil'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_circle, color: Utils.customGreenColor),
      title: Text('profile'),
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.settings, color: Utils.customGreenColor),
        title: Text('settings'))
  ];

  void _incrementTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  BottomNavigationBar create(int index) => BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
      currentIndex: _currentIndex,
      items: _items,
      onTap: _incrementTab);

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetsPage = [
      Home(),
      ChangeNotifierProvider.value(
          value: PictureProvider(), child: ProfilePage()),
      SettingsPage(),
    ];
    return Scaffold(
      bottomNavigationBar: create(_currentIndex),
      body: IndexedStack(
        index: _currentIndex,
        children: _widgetsPage,
      ),
    );
  }
}
