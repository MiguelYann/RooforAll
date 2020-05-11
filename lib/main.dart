import 'package:flutter/material.dart';
import 'package:rooforall/ui/pages/login.dart';

import 'ui/pages/bottom_navigation.dart';
import 'ui/pages/home.dart';
import 'ui/resources/utils/utils.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          Home.routeName: (BuildContext context) => Home(),
          BottomNavigation.routeName: (BuildContext context) => BottomNavigation()
        },
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'SFPro',
          //  primarySwatch: Utils.colorcolorFromHex("#00BFA6"),
        ),
        home: Login());
  }
}
