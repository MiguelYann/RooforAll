import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  final String title;

  const SettingPage(this.title) : assert(title != null);

  @override
  Widget build(BuildContext context) {
    final text = Text('Setting');
    return Scaffold(
      body: Container(
        child: Center(child: text),
      ),
      appBar: AppBar(title: text),
    );
  }
}