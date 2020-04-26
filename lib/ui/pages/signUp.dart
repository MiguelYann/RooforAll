import 'package:flutter/material.dart';
import 'package:rooforall/data/repository/user_repository.dart';
import 'package:rooforall/ui/pages/login.dart';
import 'package:rooforall/ui/resources/widgets/input_user.dart';

class SignUp extends StatelessWidget {
//  Color backGroundColor = Utils.colorFromHex('#9f9fa3');
  static const fontText = 'SFPro';
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _userNameEditingController =
      TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();

  void _signUp(String username, String mail, String password) async {
    var response =
        await UserRepository().registerUser(username, mail, password);
    print(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 50),
            child: Text(
              'Enregistrez Vous',
              style: TextStyle(
                  fontFamily: fontText,
                  fontSize: 25,
                  color: Colors.indigoAccent,
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
                      textInput: _emailEditingController,
                      iconItem: Icons.email,
                      labelInput: 'Email',
                    )),
                Container(
                    margin: EdgeInsets.only(top: 20),
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: UserInput(
                      textInput: _userNameEditingController,
                      iconItem: Icons.email,
                      labelInput: 'Username',
                    )),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: UserInput(
                    textInput: _passwordEditingController,
                    iconItem: Icons.vpn_key,
                    labelInput: 'Password',
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2,
            child: RaisedButton(
              child: Text(
                'Sign Up',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: fontText,
                    fontWeight: FontWeight.bold),
              ),
              color: Colors.indigoAccent,
              onPressed: () {
                print(_emailEditingController.text);
                print(_userNameEditingController.text);
                print(_passwordEditingController.text);
                _signUp(
                    _emailEditingController.text,
                    _userNameEditingController.text,
                    _passwordEditingController.text);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => Login()));
              },
              child: Text(
                'Login',
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  color: Colors.indigoAccent,
                  fontSize: 15.0,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
          ////////////   new account///////////////
        ],
      ),
    );
  }
}
