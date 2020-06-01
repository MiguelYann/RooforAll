import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rooforall/data/provider/user_provider.dart';
import 'package:rooforall/data/models/news_description.dart';
import 'package:rooforall/ui/resources/responsive/device_screen_type.dart';
import 'package:rooforall/ui/resources/utils/theme_notif.dart';
import 'package:rooforall/ui/resources/utils/utils.dart';
import 'package:rooforall/ui/resources/widgets/base_widget.dart';
import 'package:rooforall/ui/resources/widgets/separated.dart';

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

  @override
  Widget build(BuildContext context) {
    print("REBUILD REBUIDL REBUILD");
    var _darkTheme = true;
    final themeNotifier = Provider.of<ThemeNotif>(context);
    _darkTheme = (themeNotifier.getTheme() == Utils.darktheme);
    final user = Provider.of<UserProvider>(context, listen: false);
    return BaseWidget(builder: (context, sizingInformation) {
      if (sizingInformation.deviceScreenType == DeviceScreenType.Mobile) {
        return Scaffold(
          backgroundColor: !_darkTheme ? Colors.white : Colors.black,
          body: FutureBuilder(
            future: Provider.of<UserProvider>(context, listen: false)
                .getUserInformation(),
            builder: (ctx, asynchrone) {
              print(asynchrone.hasData);
              if (asynchrone.hasData) {
                return SafeArea(
                  child: ListView(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(30),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    'Hello ${user.username}',
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
                                    ? Stack(
                                  children: <Widget>[
                                    Container(
                                      height: 70,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        color: Colors.amber,
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTdn-7SHPiGEA0vsZW7e_qUqzQ4LEoMvHOVAPljSlVnxjJ9fKWl&usqp=CAU',
                                            ),
                                            fit: BoxFit.cover),
                                        border: Border.all(
                                            style: BorderStyle.none),
                                        borderRadius:
                                        BorderRadius.circular(40),
                                      ),
                                    ),
                                    new Positioned(
                                      right: 0,
                                      child: new Container(
                                        padding: EdgeInsets.all(1),
                                        decoration: new BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                          BorderRadius.circular(6),
                                        ),
                                        constraints: BoxConstraints(
                                          minWidth: 12,
                                          minHeight: 12,
                                        ),
                                        child: new Text(
                                          '1',
                                          style: new TextStyle(
                                              color: Colors.white,
                                              fontSize: 8,
                                              fontFamily:
                                              Utils.customFont,
                                              fontWeight:
                                              FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    )
                                  ],
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(top: 40),
                              height:
                              MediaQuery
                                  .of(context)
                                  .size
                                  .height / 1.75,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color:
                                !_darkTheme ? Colors.transparent : null,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40),
                                ),
                              ),
                              child: Separated(
                                datas: asynchrone.data,
                              )),
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        );
      }
    });
  }
}

