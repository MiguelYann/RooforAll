import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rooforall/data/provider/user_provider.dart';
import 'package:rooforall/data/models/news_description.dart';
import 'package:rooforall/ui/resources/utils/theme_notif.dart';
import 'package:rooforall/ui/resources/utils/utils.dart';
import 'package:rooforall/ui/resources/widgets/separated.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' as Io;

class Home extends StatefulWidget {
  static final String routeName = "/home";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<dynamic> records;

  @override
  void initState() {
    super.initState();
  }

  Future<Image> getImageFromPath(String path) async {
    final bytes = await Io.File(path).readAsBytes();
    final image64 = base64Encode(bytes);
    return Image.memory(base64Decode(image64));
  }

  @override
  Widget build(BuildContext context) {
    print("REBUILD Home");
    var _darkTheme = true;
    final themeNotifier = Provider.of<ThemeNotif>(context);
    _darkTheme = (themeNotifier.getTheme() == Utils.darktheme);
    return Scaffold(
        backgroundColor: !_darkTheme ? Colors.white : Colors.black,
        body: Scaffold(
            body: SafeArea(
                child: ListView(children: <Widget>[
          FutureBuilder(
            future: SharedPreferences.getInstance(),
            builder: (context, snapShot) {
              if (snapShot.hasData) {
                return Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  'Hello ${snapShot.data.getString("username")}',
                                  style: TextStyle(
                                    fontFamily: Utils.customFont,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: !_darkTheme
                                        ? Utils.customPurpleColor
                                        : null,
                                  ),
                                ),
                              ),
                              !_darkTheme
                                  ? FutureBuilder(
                                      future: getImageFromPath(
                                        snapShot.data.getString("imageProfile"),
                                      ),
                                      builder: (ctx, snapshotImage) {
                                        if (snapshotImage.hasData) {
                                          return Stack(
                                            children: <Widget>[
                                              CircleAvatar(
                                                radius: 52,
                                                backgroundImage:
                                                    snapshotImage.data.image,
                                              ),
                                            ],
                                          );
                                        } else {
                                          return Stack(
                                            children: <Widget>[
                                              CircleAvatar(
                                                  radius: 52.0,
                                                  backgroundImage: NetworkImage(
                                                      "https://cdn.pixabay.com/photo/2013/07/13/12/07/avatar-159236_640.png")),
                                            ],
                                          );
                                        }
                                      },
                                    )
                                  : Container(),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    CarouselSlider.builder(
                        itemBuilder: (_, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                height: 20,
                                width: 70,
                                child: Center(
                                  child: Text(
                                    "NOUVEAU",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: Utils.customFont,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        News.descriptionNews[index].image),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                height: 180,
                                width: double.infinity,
                              ),
                              Text(News.descriptionNews[index].title,
                                  style: TextStyle(
                                    color: Utils.customPurpleColor,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Utils.customFont,
                                  ))
                            ],
                          );
                        },
                        itemCount: News.descriptionNews.length,
                        options: CarouselOptions(
                          height: 330,
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.8,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                        )),
                    Center(
                      child: Container(
                        child: Text("RETROUVES TES DOSSIERS",
                            style: TextStyle(
                                color: Utils.customGreenColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                fontFamily: Utils.customFont)),
                      ),
                    ),
                  ],
                );
              }
              return Text("Login");
            },
          ),
          FutureBuilder(
              future: Provider.of<UserProvider>(context, listen: true)
                  .getUserInformation(),
              builder: (ctx, asynchrone) {
                print("DATA REBUILD ${asynchrone.data}");
                print(asynchrone.hasData);
                if (asynchrone.hasData) {
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(top: 40),
                            height: MediaQuery.of(context).size.height / 1.75,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: !_darkTheme ? Colors.transparent : null,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40),
                              ),
                            ),
                            child:
                                Separated(datas: asynchrone.data["records"])),
                      ]);
                } else {
                  return Text("");
                }
              }),
        ]))));
  }
}
