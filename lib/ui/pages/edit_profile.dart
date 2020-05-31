import 'package:flutter/material.dart';
import 'package:rooforall/ui/resources/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  final String currentId;

  const EditProfile({Key key, this.currentId}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController _textEditingControllerUsername =
      TextEditingController();
  TextEditingController _textEditingControllerUserMail =
      TextEditingController();
  final _scaffoldGlobalKey = GlobalKey<ScaffoldState>();
  bool loading = false;
  bool _validName = true;
  bool _validEmail = true;

  bool _mailValid = true;

  updateData() {
    setState(() {
      _textEditingControllerUsername.text.isEmpty
          ? _validName = false
          : _validName = true;
      _textEditingControllerUserMail.text.isEmpty
          ? _validEmail = false
          : _validEmail = true;
    });

    if (_validEmail && _validName) {
      //update
      SnackBar successSnackBar = SnackBar(
        content: Text(
          "Profile mis a jour avec succes",
          style: TextStyle(
            fontFamily: Utils.customFont,
          ),
        ),
        backgroundColor: Colors.amber,
      );
      _scaffoldGlobalKey.currentState.showSnackBar(successSnackBar);
    }
  }

  @override
  void initState() {
    super.initState();
    getAndDisplayUserInformation();
  }

  void getAndDisplayUserInformation() async {
    setState(() {
      loading = true;
    });

    final _sharePreferences = await SharedPreferences.getInstance();
    _textEditingControllerUsername.text =
        _sharePreferences.getString("username");

    _textEditingControllerUserMail.text =
        _sharePreferences.getString("userMail");

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldGlobalKey,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Utils.customGreenColor,
        title: Text(
          "Modifier mon profil",
          style: TextStyle(
            color: Colors.white,
            fontFamily: Utils.customFont,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.done,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: loading
          ? CircularProgressIndicator()
          : ListView(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 52.0,
                          backgroundImage: NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTdn-7SHPiGEA0vsZW7e_qUqzQ4LEoMvHOVAPljSlVnxjJ9fKWl&usqp=CAU',
                          ),
                        ),
                        Text(
                          "Modifier image",
                          style: TextStyle(
                            color: Utils.customGreenColor,
                            fontFamily: Utils.customFont,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    createProfileNameTextFormField(context),
                    SizedBox(
                      height: 30,
                    ),
                    createProfileEmailTextFormField(),
                    SizedBox(
                      height: 80,
                    ),
                    FlatButton(
                      onPressed: updateData,
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1,
                        height: 76,
                        child: Text(
                          "Enregistrer",
                          style: TextStyle(
                            fontFamily: Utils.customFont,
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Utils.customPurpleColor,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }

  Container createProfileNameTextFormField(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      child: TextField(
          style: TextStyle(
            fontFamily: Utils.customFont,
          ),
          controller: _textEditingControllerUsername,
          decoration: InputDecoration(
              hintText: "Ecrire votre nom",
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                  color: Colors.grey,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                  color: Colors.grey,
                ),
              ),
              hintStyle: TextStyle(
                color: Colors.grey,
                fontFamily: Utils.customFont,
              ),
              errorText: _validName ? null : "Profile name is short")),
    );
  }

  Container createProfileEmailTextFormField() {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      child: TextField(
        style: TextStyle(
          fontFamily: Utils.customFont,
        ),
        controller: _textEditingControllerUserMail,
        decoration: InputDecoration(
          hintText: "Ecrire votre email",
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              style: BorderStyle.solid,
              color: Colors.grey,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              style: BorderStyle.solid,
              color: Colors.grey,
            ),
          ),
          hintStyle:
              TextStyle(color: Colors.grey, fontFamily: Utils.customFont),
          errorText: _validEmail ? null : "Profile email is short",
        ),
      ),
    );
  }
}
