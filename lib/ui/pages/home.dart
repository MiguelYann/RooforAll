import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rooforall/ui/pages/setting.dart';

class Home extends StatelessWidget {
  //final String title;
  static final String routeName = "/home";

 // const Home(this.title) : assert(title != null);

  @override
  Widget build(BuildContext context) {

        final String username  = ModalRoute.of(context).settings.arguments;

    final text = Text(username);
    return Scaffold(
      body: Container(
        child: Center(child: text),
      ),
      appBar: AppBar(title: text),
    );
  }
}
