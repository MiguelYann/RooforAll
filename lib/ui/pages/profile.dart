import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String title;

  const ProfilePage(this.title) : assert(title != null);

  @override
  Widget build(BuildContext context) {
    final text = Text('Profile');
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
              child: Container(
          child: Center(child: text),
        ),
      ),
      appBar: AppBar(
        title: text,
        automaticallyImplyLeading: false,
      ),
    );
  }
}
