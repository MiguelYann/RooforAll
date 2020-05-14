import 'package:flutter/material.dart';
import 'package:rooforall/data/repository/user_repository.dart';
import 'package:rooforall/ui/pages/login.dart';
import 'package:rooforall/ui/resources/utils/utils.dart';
import 'package:rooforall/ui/resources/widgets/input_user.dart';

class SignUp extends StatelessWidget {
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
                      textInput: _emailEditingController,
                      prefixiconItem: Icons.email,
                      labelInput: 'Email',
                    )),
                Container(
                    margin: EdgeInsets.only(top: 20),
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
                    textInput: _passwordEditingController,
                    prefixiconItem: Icons.vpn_key,
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
                    fontFamily: Utils.customFont,
                    fontWeight: FontWeight.bold),
              ),
              color: Utils.colorFromHex("#00BFA6"),
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
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => Login()));
              },
              child: Text(
                'Login',
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  color: Utils.colorFromHex("#00BFA6"),
                  fontSize: 15.0,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
