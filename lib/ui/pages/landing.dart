import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rooforall/data/models/slider_item.dart';
import 'package:rooforall/ui/pages/login.dart';
import 'package:rooforall/ui/resources/utils/theme.dart';
import 'package:rooforall/ui/resources/utils/theme_notif.dart';
import 'package:rooforall/ui/resources/utils/utils.dart';
import 'package:rooforall/ui/resources/widgets/slider_landing.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  List<SliderItem> _slides = List<SliderItem>();
  int _currentIndex = 0;
  PageController _pageController = PageController(initialPage: 0);
  bool isviewer = false;

  @override
  void initState() {
    print("LANDING");

    super.initState();

    _slides = SliderItem().getSliderItems();
  }

  void goToLogin(BuildContext buildContext) {
    Navigator.pushNamed(buildContext, Login.routeName);
  }

  Widget currentIndicatorPage(bool isCurrentPage) {
    return Container(
      height: isCurrentPage ? 6 : 6.0,
      width: isCurrentPage ? 6 : 6.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          border: Border.all(style: BorderStyle.none),
          color: isCurrentPage ? Utils.customPurpleColor : Colors.grey),
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
    return aList;
  }

  @override
  Widget build(BuildContext context) {
    var _darkTheme = true;
    print("Build Landing");
    SharedPreferences.getInstance().then((pref) => {
          pref.setBool("seen", true)
        });
    final themeNotifier = Provider.of<ThemeNotif>(context);
    _darkTheme = (themeNotifier.getTheme() == Utils.darktheme);

//    onView(isviewer, vuee);

    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        itemCount: _slides.length,
        itemBuilder: (context, index) {
          return SliderLanding(
            imagePath: _slides[index].pathImage,
            description: _slides[index].description,
            title: _slides[index].title,
          );
        },
      ),
      bottomSheet: _currentIndex != _slides.length - 1
          ? Container(
              height: Platform.isIOS ? 70 : 60,
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      _pageController.animateToPage(
                        (_slides.length - 1),
                        duration: Duration(milliseconds: 400),
                        curve: Curves.linear,
                      );
                    },
                    child: Text(
                      'PASSER',
                      style: TextStyle(
                          fontFamily: Utils.customFont,
                          color: _darkTheme
                              ? Theme.of(context).accentColor
                              : Utils.customPurpleColor,
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
                    onTap: () {
                      _pageController.animateToPage(
                        (_currentIndex + 1),
                        duration: Duration(milliseconds: 400),
                        curve: Curves.linear,
                      );
                    },
                    child: Text(
                      'SUIVANT',
                      style: TextStyle(
                          fontFamily: Utils.customFont,
                          color: _darkTheme
                              ? Theme.of(context).accentColor
                              : Utils.customPurpleColor,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            )
          : InkWell(
              onTap: () => goToLogin(context),
              child: Container(
                alignment: Alignment.center,
                height: 90,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'COMMENCER',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: Utils.customFont,
                      fontWeight: FontWeight.bold),
                ),
                color: Utils.customGreenColor,
              ),
            ),
    );
  }
}
