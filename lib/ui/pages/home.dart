import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rooforall/ui/pages/setting.dart';

class Home extends StatelessWidget {
  final String title;

  const Home(this.title) : assert(title != null);

  @override
  Widget build(BuildContext context) {
    final text = Text('Home');
    return Scaffold(
      body: Container(
        child: Center(child: text),
      ),
      appBar: AppBar(title: text),
    );
  }
}
