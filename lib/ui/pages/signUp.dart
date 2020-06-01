import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:rooforall/data/provider/user_provider.dart';
import 'package:rooforall/data/repository/user_repository.dart';
import 'package:rooforall/ui/pages/login.dart';
import 'package:rooforall/ui/resources/utils/utils.dart';
import 'package:rooforall/ui/resources/widgets/bottom_navigation.dart';
import 'package:rooforall/ui/resources/widgets/input_user.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailEditingController = TextEditingController();

  final TextEditingController _userNameEditingController =
      TextEditingController();

  final TextEditingController _passwordEditingController =
      TextEditingController();

  void _signUp(
      String username, String mail, String password, BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    userProvider.registerUser(mail, username, password);
    Navigator.pushNamed(context, BottomNavigation.routeName);
  }

  @override
  Widget build(BuildContext context) {
    print("Build Sign");
    return Scaffold(
      body: ListView(
        children: <Widget>[
          SvgPicture.asset(
            "assets/images/signup.svg",
            height: MediaQuery.of(context).size.height / 5,
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 50),
              child: Text(
                'Enregistrez Vous',
                style: TextStyle(
                    fontFamily: Utils.customFont,
                    fontSize: 25,
                    color: Utils.customPurpleColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: UserInput(
                      showPassword: false,
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
                      labelInput: 'Nom utilisateur',
                    )),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: UserInput(
                    textInput: _passwordEditingController,
                    prefixiconItem: Icons.vpn_key,
                    labelInput: 'Mot de passe',
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.width / 9,
                child: RaisedButton(
                  child: Text(
                    "Je m'inscris",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: Utils.customFont,
                        fontWeight: FontWeight.bold),
                  ),
                  color: Utils.customGreenColor,
                  onPressed: () => _signUp(
                      _userNameEditingController.text,
                      _emailEditingController.text,
                      _passwordEditingController.text,
                      context),
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
                    'Vous avez deja un compte?',
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      color: Utils.customGreenColor,
                      fontSize: 15.0,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w100,
                    ),
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
