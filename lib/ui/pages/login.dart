import 'package:flutter/material.dart';
import 'package:rooforall/data/repository/user_repository.dart';
import 'package:rooforall/ui/pages/signUp.dart';
import 'package:rooforall/ui/resources/widgets/input_user.dart';

class Login extends StatefulWidget {
//  Color backGroundColor = Utils.colorFromHex('#9f9fa3');
  static const fontText = 'SFPro';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _userNameEditingController =
      TextEditingController();

  final TextEditingController _passwordEditingController =
      TextEditingController();

  bool isVisiblePassword = false;

  void showPassord() {
    this.setState(() {
      isVisiblePassword = !isVisiblePassword;
    });
  }

  void _logUser(String mail, String password) async {
    var response = await UserRepository().logUser(mail, password);

    //TODO HANDLE ERROR
//    switch (response.statusCode) {
//      case 200:
//        print('connected');
//        break;
//      case 401:
//        print('auntorized');
//        break;
//      case 403:
//        print('forbiden');
//        break;
//      case 404:
//        print('not found');
//    }
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
              'Connectez vous',
              style: TextStyle(
                  fontFamily: Login.fontText,
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
                        fontFamily: Login.fontText,
                        color: Colors.indigoAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2,
            child: RaisedButton(
              child: Text(
                'Login',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: Login.fontText,
                    fontWeight: FontWeight.bold),
              ),
              color: Colors.indigoAccent,
              onPressed: () {
                print(_userNameEditingController.text);
                print(_passwordEditingController.text);
                _logUser(_userNameEditingController.text,
                    _passwordEditingController.text);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => SignUp()));
              },
              child: Text(
                'Creer un nouveau compte',
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
        ],
      ),
    );
  }
}
