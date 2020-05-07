import 'package:flutter/material.dart';
import 'package:rooforall/ui/pages/login.dart';

import 'ui/resources/utils/utils.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'SFPro',
          //  primarySwatch: Utils.colorcolorFromHex("#00BFA6"),
        ),
        home: Login());
  }
}
