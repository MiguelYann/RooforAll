import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rooforall/ui/resources/utils/utils.dart';

class SliderScreenSplash extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  SliderScreenSplash({this.imagePath, this.description, this.title});
  @override
  Widget build(BuildContext context) {
    const fontText = 'SFPro';
    Color color = Utils.colorFromHex("#29264E");

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
          Text(
            title,
            style: TextStyle(
              color: color,
              fontFamily: fontText,
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(
            height: 13,
          ),
          Text(description, style: TextStyle(fontFamily: fontText, color: color))
        ],
      ),
    );
  }
}
