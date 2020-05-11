import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rooforall/ui/pages/setting.dart';

class Home extends StatelessWidget {
  final String currentUsername;
  static final String routeName = "/home";

  const Home({this.currentUsername});

  @override
  Widget build(BuildContext context) {
    final text = Text("Home");
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            child: Text("Bonjour $currentUsername"),
          ),
        ],
      ),
      appBar: AppBar(title: text),
    );
  }
}
