import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rooforall/data/repository/user_repository.dart';
import 'package:rooforall/ui/pages/signUp.dart';
import 'package:rooforall/ui/resources/utils/utils.dart';
import 'package:rooforall/ui/resources/widgets/bottom_navigation.dart';
import 'package:rooforall/ui/resources/widgets/input_user.dart';
import 'package:flutter_svg/flutter_svg.dart';


class Login extends StatefulWidget {
  static final String routeName = "/login";

  @override
  _LoginState createState() => _LoginState();
}

enum LogStatus { INITIAL, SUCESS_CONNECT, FAIL_CONNECT }

class _LoginState extends State<Login> {
  final TextEditingController _userNameEditingController =
      TextEditingController();

  final TextEditingController _passwordEditingController =
      TextEditingController();

  bool isVisiblePassword = false;
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

  Future<void> _logUser(String mail, String password) async {
    try {
      Response response = await UserRepository().logUser(mail, password);
      Headers headers = await response.headers;
      String token = await headers.value("authorization").substring(7);
print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          setState(() {
            logStatus = LogStatus.SUCESS_CONNECT;
          });
          break;

        case 401:
          setState(() {
            logStatus = LogStatus.FAIL_CONNECT;
          });
          break;

        case 403:
          setState(() {
            logStatus = LogStatus.FAIL_CONNECT;
          });
          break;

        case 404:
          setState(() {
            logStatus = LogStatus.FAIL_CONNECT;
          });
          break;

        default:
          setState(() {
            logStatus = LogStatus.INITIAL;
          });
      }

      Navigator.pushNamed(context, BottomNavigation.routeName,
          arguments: response.data["username"]);
    } catch (e) {
      print('dddd');
      setState(() {
        logStatus = LogStatus.FAIL_CONNECT;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
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
                    color: Utils.colorFromHex("#00BFA6"),
                    fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: UserInput(
                        textInput: _userNameEditingController,
                        prefixiconItem: Icons.email,
                        labelInput: 'Username',
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
                        labelInput: 'Password',
                      )),
                  InkWell(
                      onTap: () {},
                      child: Text(
                        'Forgot password',
                        style: TextStyle(
                          fontFamily: Utils.customFont,
                          color: Utils.colorFromHex("#00BFA6"),
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ],
              ),
            ),
            (logStatus == LogStatus.FAIL_CONNECT)
                ? Container(
                    child: Text(
                      'Vos indentifiants sont semblent incorrectes',
                      style: TextStyle(
                          color: Colors.red, fontStyle: FontStyle.italic),
                    ),
                  )
                : Container(),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              child: RaisedButton(
                child: Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: Utils.customFont,
                      fontWeight: FontWeight.bold),
                ),
                color: Utils.colorFromHex("#00BFA6"),
                onPressed: () {
                  _logUser(_userNameEditingController.text,
                      _passwordEditingController.text);
                },
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              child: OutlineButton(
                  borderSide: BorderSide(color: Utils.colorFromHex("#00BFA6")),
                  child: Text(
                    "S'inscrire",
                    style: TextStyle(
                        color: Utils.colorFromHex("#00BFA6"),
                        fontFamily: Utils.customFont,
                        fontWeight: FontWeight.bold),
                  ),
                  color: Colors.white,
                  onPressed: () => navigateLoginToRegister(context)),
            ),
          ],
        ),
      ),
    );
  }
}
