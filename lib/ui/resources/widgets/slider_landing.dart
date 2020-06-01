import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:rooforall/ui/resources/utils/theme_notif.dart';
import 'package:rooforall/ui/resources/utils/utils.dart';

class SliderLanding extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  SliderLanding({this.imagePath, this.description, this.title});
  @override
  Widget build(BuildContext context) {
    var _darkTheme = true;

    final themeNotifier = Provider.of<ThemeNotif>(context);
    _darkTheme = (themeNotifier.getTheme() == Utils.darktheme);
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
              color: _darkTheme
                  ? Colors.white
                  : Utils.customPurpleColor,
              fontFamily: Utils.customFont,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 13,
          ),
          Text(
            description,
            style: TextStyle(
              fontFamily: Utils.customFont,
              color: !_darkTheme
                  ? Utils.customPurpleColor
                  : Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
