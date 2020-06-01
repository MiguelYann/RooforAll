import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rooforall/data/provider/user_provider.dart';
import 'package:rooforall/data/repository/user_repository.dart';
import 'package:rooforall/ui/pages/signUp.dart';
import 'package:rooforall/ui/resources/utils/theme_notif.dart';
import 'package:rooforall/ui/resources/utils/utils.dart';
import 'package:rooforall/ui/resources/widgets/bottom_navigation.dart';
import 'package:rooforall/ui/resources/widgets/input_user.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class Login extends StatefulWidget {
  static final String routeName = "/login";

  @override
  _LoginState createState() => _LoginState();
}

enum LogStatus { INITIAL, SUCESS_CONNECT, FAIL_CONNECT }

class _LoginState extends State<Login> {
  bool _isLoading = false;
  final TextEditingController _userNameEditingController =
      TextEditingController();

  final TextEditingController _passwordEditingController =
      TextEditingController();

  bool isVisiblePassword = true;
  LogStatus logStatus = LogStatus.INITIAL;

  void showPassord() {
    this.setState(() {
      isVisiblePassword = !isVisiblePassword;
    });
  }

  void navigateLoginToRegister(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
  }

  Widget manageStatusConnection() {
    switch (logStatus) {
      case LogStatus.INITIAL:
        return Container();

      case LogStatus.SUCESS_CONNECT:
        return Container();

      case LogStatus.FAIL_CONNECT:
        return Container(
            child: Text(
          "Try again",
          style: TextStyle(
            color: Colors.red,
          ),
        ));
      default:
        return Container();
    }
  }

  void displayDialog(context, title, text) => showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

  Future<void> _logUser(
      String mail, String password, BuildContext buildContext) async {
    try {
      setState(() {
        _isLoading = true;
      });
      final userProvider = Provider.of<UserProvider>(context);
      final response = await userProvider.logUser(mail, password);
      setState(() {
        _isLoading = false;
      });
      print(_isLoading);
      // Headers headers =  response.headers;
      // String token =  headers.value("authorization").substring(7);

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      sharedPreferences.setString("token", userProvider.token);
      Navigator.pushNamed(context, BottomNavigation.routeName,
          arguments: userProvider.username);
      print("RECU ${userProvider.username}");
    } catch (e) {
      setState(() {
        _isLoading = false;
        // logStatus = LogStatus.FAIL_CONNECT;
      });
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
            titlePadding: EdgeInsets.all(20),
            title: Text(
              'Erreur de connexion',
              style: TextStyle(
                fontFamily: 'SFPro',
              ),
            ),
            content: Text(
              'Vos identifiants semblent incorrects',
              style: TextStyle(color: Colors.redAccent),
            )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var _darkTheme = true;

    final themeNotifier = Provider.of<ThemeNotif>(context);
    _darkTheme = (themeNotifier.getTheme() == Utils.darktheme);
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(60),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SvgPicture.asset(
                "assets/images/undraw.svg",
                height: MediaQuery.of(context).size.height / 4,
              ),
              Container(
                child: Text(
                  'Connectez vous',
                  style: TextStyle(
                      fontFamily: Utils.customFont,
                      fontSize: 25,
                      color:
                          _darkTheme ? Colors.white : Utils.customPurpleColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                        width: MediaQuery.of(context).size.width / 1.3,
                        child: UserInput(
                          showPassword: false,
                          textInput: _userNameEditingController,
                          prefixiconItem: Icons.email,
                          labelInput: "Entrer votre nom d'utilisateur",
                        )),
                    Container(
                        margin: EdgeInsets.only(top: 20),
                        width: MediaQuery.of(context).size.width / 1.3,
                        child: UserInput(
                          showPassword: isVisiblePassword,
                          setVisiblePassword: this.showPassord,
                          textInput: _passwordEditingController,
                          prefixiconItem: Icons.vpn_key,
                          suffixIconIten: Icons.remove_red_eye,
                          labelInput: 'Entrer votre mot de passe',
                        )),
                    SizedBox(
                      height: 17,
                    ),
                    InkWell(
                        onTap: () {},
                        child: Text(
                          'Mot de passe oublié',
                          style: TextStyle(
                              fontFamily: Utils.customFont,
                              color: Utils.customGreenColor,
                              fontSize: 12),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 37,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.width / 8,
                child: RaisedButton(
                  child: !_isLoading
                      ? Text(
                          'Connexion',
                          style: TextStyle(
                              color: !_darkTheme
                                  ? Colors.white
                                  : Utils.customPurpleColor,
                              fontFamily: Utils.customFont,
                              fontWeight: FontWeight.bold),
                        )
                      : CupertinoActivityIndicator(
                          animating: true,
                        ),
                  color: _darkTheme ? Colors.white : Utils.customPurpleColor,
                  onPressed: () {
                    _logUser(_userNameEditingController.text,
                        _passwordEditingController.text, context);
                  },
                ),
              ),
              SizedBox(
                height: 17,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.width / 8,
                child: RaisedButton(
                    child: Text(
                      "S'inscrire",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: Utils.customFont,
                          fontWeight: FontWeight.bold),
                    ),
                    color: Utils.customGreenColor,
                    onPressed: () => navigateLoginToRegister(context)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
