import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rooforall/data/models/slider_item.dart';
import 'package:rooforall/ui/resources/utils/utils.dart';
import 'package:rooforall/ui/resources/widgets/slider_screen_splash.dart';

class ScreenSplash extends StatefulWidget {
  @override
  _ScreenSplashState createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  static const fontText = 'SFPro';

  List<SliderItem> _slides = List<SliderItem>();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _slides = SliderItem().getSliderItems();
  }

  Widget currentIndicatorPage(bool isCurrentPage) {
    return Container(
      height: isCurrentPage ? 6 : 6.0,
      width: isCurrentPage ? 6 : 6.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          border: Border.all(style: BorderStyle.none),
          color: isCurrentPage ? Utils.colorFromHex("#00BFA6") : Colors.grey),
    );
  }

  List<Widget> getIndicator(int index) {
    List<Widget> aList = List<Widget>();

    for (int i = 0; i < _slides.length; i++) {
      if (index == i) {
        aList.add(currentIndicatorPage(true));
      } else {
        aList.add(currentIndicatorPage(false));
      }
    }
    print(aList);
    return aList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        onPageChanged: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        itemCount: _slides.length,
        itemBuilder: (context, index) {
          return SliderScreenSplash(
            imagePath: _slides[index].pathImage,
            description: _slides[index].description,
            title: _slides[index].title,
          );
        },
      ),
      bottomSheet: _currentIndex != _slides.length
          ? Container(
              height: Platform.isIOS ? 70 : 60,
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                    child: Text(
                      'PASSER',
                      style: TextStyle(
                          fontFamily: fontText,
                          color: Utils.colorFromHex("#00BFA6"),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ...getIndicator(_currentIndex),
                    ],
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      'SUIVANT',
                      style: TextStyle(
                          fontFamily: fontText,
                          color: Utils.colorFromHex("#00BFA6"),
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            )
          : Container(
              child: Text('dd'),
            ),
    );
  }
}
