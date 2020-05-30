import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rooforall/data/provider/user_provider.dart';
import 'package:rooforall/ui/resources/utils/theme_notif.dart';
import 'package:rooforall/ui/resources/utils/utils.dart';
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

  // @override
  // // void didChangeDependencies() async {
  // //   final userProvider = Provider.of<UserProvider>(context, listen: false);
  // //   print(await userProvider.getUserInformation(userProvider.token));
  // //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    print("REBUILD REBUIDL REBUILD");
    var _darkTheme = true;
    final themeNotifier = Provider.of<ThemeNotif>(context);
    _darkTheme = (themeNotifier.getTheme() == Utils.darktheme);
    final user = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: !_darkTheme ? Utils.customGreenColor : Colors.black,
      body: FutureBuilder(
        future: Provider.of<UserProvider>(context, listen: false)
            .getUserInformation(),
        builder: (ctx, asynchrone) {
          if (asynchrone.hasData) {
            print("DATA ${asynchrone.data}");
            return SafeArea(
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 100, left: 30),
                    child: Text(
                      'Hello ${user.username}',
                      style: TextStyle(
                        fontFamily: Utils.customFont,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: !_darkTheme ? Colors.white : null,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      !_darkTheme
                          ? Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                      'https://d2eip9sf3oo6c2.cloudfront.net/instructors/avatars/000/000/032/square_480/oapgW_Fp_400x400.jpg',
                                    ),
                                    fit: BoxFit.cover),
                                border: Border.all(style: BorderStyle.none),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              height: 60,
                              width: 60,
                              margin: EdgeInsets.only(top: 100, right: 50),
                            )
                          : null,
                    ],
                  ),
                  Container(
                    child: Text("Retrouves tes dossiers",
                        style: TextStyle(
                            color: Utils.customPurpleColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: Utils.customFont)),
                    margin: EdgeInsets.only(
                      top: 230,
                      left: 20,
                    ),
                  ),
                  Column(
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
}
