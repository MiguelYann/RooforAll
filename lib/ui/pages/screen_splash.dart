import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rooforall/data/models/slider_item.dart';

class ScreenSplash extends StatefulWidget {
  @override
  _ScreenSplashState createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  List<SliderItem> _slides = List<SliderItem>();

  @override
  void initState() {
    super.initState();
    _slides = SliderItem().getSliderItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: _slides.length,
        itemBuilder: (context, index) {
          return SliderText(
            imagePath: _slides[index].pathImage,
            description: _slides[index].description,
            title: _slides[index].title,
          );
        },
      ),
    );
  }
}

class SliderText extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  SliderText({this.imagePath, this.description, this.title});
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
