import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rooforall/data/provider/user_provider.dart';
import 'package:rooforall/ui/resources/utils/theme_notif.dart';
import 'package:rooforall/ui/resources/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'edit_profile.dart';
import 'login.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String currentUser = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void getAndDisplayUserInformation() async {
    setState(() {
//      loading = true;
    });

//    _imageProfile = File(_sharePreferences.get("imageProfile")) ;

    setState(() {
//      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var _darkTheme = true;

    final themeNotifier = Provider.of<ThemeNotif>(context);
    _darkTheme = (themeNotifier.getTheme() == Utils.darktheme);

    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(90),
            child: Column(
              children: <Widget>[
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 13.0),
                    child: Text(
                      "${userProvider.username.toUpperCase()}" ?? "",
                      style: TextStyle(
                        color: !_darkTheme
                            ? Utils.customPurpleColor
                            : Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: Utils.customFont,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      createColums("Dossiers", userProvider.totalRecords),
                      createColums("Logements", 0),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          createButton(context, _darkTheme),
          SizedBox(
            height: 30,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.2,
            height: 76,
            child: FlatButton(
              onPressed: () {
                userProvider.logOut();
                Navigator.pushNamed(context, Login.routeName);
              },
              child: Text(
                "Deconnexion",
                style: TextStyle(
                  fontFamily: Utils.customFont,
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color:!_darkTheme ?  Utils.customPurpleColor: Utils.customGreenColor,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ],
      ),
    );
  }

  Column createColums(String title, int count) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "$count",
          style: TextStyle(
            color: Colors.amber,
            fontFamily: Utils.customFont,
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: EdgeInsets.all(5),
          child: Text(
            title,
            style: TextStyle(
              color: Utils.customGreenColor,
              fontWeight: FontWeight.bold,
              fontFamily: Utils.customFont,
            ),
          ),
        ),
      ],
    );
  }

  createButton(BuildContext context, isDarkMode) {
    return createButtonTitleAndFunction(
      context,
      isDarkMode,
      title: "Modifier mon profil",
      performFunction: () => editProfile(context),
    );
  }
}

editProfile(BuildContext context) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfile(),
      ));
}

createButtonTitleAndFunction(BuildContext context, bool isDarkMode,
    {String title, Function performFunction}) {
  return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
            color: !isDarkMode ? Utils.customPurpleColor : Utils.customGreenColor),
        borderRadius: BorderRadius.circular(6),
      ),
      width: MediaQuery.of(context).size.width / 1.2,
      height: 76,
      child: FlatButton(
        onPressed: performFunction,
        child: Text(
          title,
          style: TextStyle(
            fontFamily: Utils.customFont,
            color: !isDarkMode ? Utils.customPurpleColor : Utils.customGreenColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ));
}
