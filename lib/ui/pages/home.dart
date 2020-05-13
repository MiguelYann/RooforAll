import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rooforall/ui/pages/setting.dart';
import 'package:rooforall/ui/resources/utils/utils.dart';

class Home extends StatelessWidget {
  static const fontText = 'SFPro';

  final String currentUsername;
  static final String routeName = "/home";

  const Home({this.currentUsername});
/**
 * TODO: REFACTO la variable partagee pour la couleur 
 */
  @override
  Widget build(BuildContext context) {
    Color primaryColor = Utils.colorFromHex("#00BFA6");
    final text = Text("Home");

    return Scaffold(
      backgroundColor: primaryColor,
      body: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 100, left: 30),
            child: Text(
              'Bonjour $currentUsername',
              style: TextStyle(
                fontFamily: fontText,
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://d2eip9sf3oo6c2.cloudfront.net/instructors/avatars/000/000/032/square_480/oapgW_Fp_400x400.jpg'),
                      fit: BoxFit.cover),
                  border: Border.all(style: BorderStyle.none),
                  borderRadius: BorderRadius.circular(40),
                ),
                height: 60,
                width: 60,
                margin: EdgeInsets.only(top: 100, right: 50),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 1.75,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
