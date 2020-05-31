import 'package:flutter/material.dart';
import 'package:rooforall/ui/resources/utils/utils.dart';

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
      SnackBar successSnackBar =
          SnackBar(content: Text("Profile mis a jour avec succes"));
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

    //recuper les informations

    //assigner le username du profider a texEditingProfile.text

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldGlobalKey,
      appBar: AppBar(
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
                Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          top: 15.0,
                          bottom: 7.0,
                        ),
                        child: CircleAvatar(
                          radius: 52.0,
                          backgroundImage: NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTdn-7SHPiGEA0vsZW7e_qUqzQ4LEoMvHOVAPljSlVnxjJ9fKWl&usqp=CAU',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: <Widget>[
                            createProfileNameTextFormField(),
                            createProfileEmailTextFormField(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 29.0,
                          left: 50.0,
                          right: 50.0,
                        ),
                        child: RaisedButton(
                          child: Text(
                            "Update",
                            style: TextStyle(
                              fontFamily: Utils.customFont,
                            ),
                          ),
                          onPressed: updateData,
                        ),
                      ),

//                      Padding(
//                        padding: EdgeInsets.only(
//                          top: 29.0,
//                          left: 50.0,
//                          right: 50.0,
//                        ),
//                        child: RaisedButton(
//                          child: Text(
//                            "LOGout",
//                            style: TextStyle(
//                              fontFamily: Utils.customFont,
//                            ),
//                          ),
//                          onPressed: () {},
//                        ),
//                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }

  Column createProfileNameTextFormField() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 13.0),
          child: Text(
            "Nom utilisateur",
            style: TextStyle(
              color: Colors.red,
              fontFamily: Utils.customFont,
            ),
          ),
        ),
        TextField(
          style: TextStyle(
            fontFamily: Utils.customFont,
          ),
          controller: _textEditingControllerUsername,
          decoration: InputDecoration(
            hintText: "Ecrire votre nom",
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
            errorText: _validName ? null : "Profile name is short",
          ),
        )
      ],
    );
  }

  Column createProfileEmailTextFormField() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 13.0),
          child: Text(
            "Email utilisateur",
            style: TextStyle(
              color: Colors.red,
              fontFamily: Utils.customFont,
            ),
          ),
        ),
        TextField(
          style: TextStyle(
            fontFamily: Utils.customFont,
          ),
          controller: _textEditingControllerUserMail,
          decoration: InputDecoration(
            hintText: "Ecrire votre email",
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
            errorText: _validEmail ? null : "Profile email is short",
          ),
        )
      ],
    );
  }

}
