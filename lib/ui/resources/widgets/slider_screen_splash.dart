import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SliderScreenSplash extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  SliderScreenSplash({this.imagePath, this.description, this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(
            imagePath,
            height: MediaQuery.of(context).size.height / 4,
          ),
          SizedBox(
            height: 20,
          ),
          Text(title),
          SizedBox(
            height: 13,
          ),
          Text(description)
        ],
      ),
    );
  }
}