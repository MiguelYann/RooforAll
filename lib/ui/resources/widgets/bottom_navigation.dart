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
  var primaryColor =   Utils.colorFromHex("#00BFA6");

  int _currentIndex = 0;
  final List<Widget> _widgetsPage = [
    Home(),
    ProfilePage("Profile"),
    SettingPage("Setting"),
  ];

  var _items = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home, color: Utils.colorFromHex("#00BFA6")),
      title: Text('Accueil'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_circle, color: Utils.colorFromHex("#00BFA6")),
      title: Text('profile'),
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.settings, color: Utils.colorFromHex("#00BFA6")),
        title: Text('settings'))
  ];

  void _incrementTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  BottomNavigationBar create(int index) => BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      items: _items,
      onTap: _incrementTab);

  @override
  Widget build(BuildContext context) {
    final String username = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      bottomNavigationBar: create(_currentIndex),
      body: IndexedStack(
        index: _currentIndex,
        children: _widgetsPage,
      ),
    );
  }
}
