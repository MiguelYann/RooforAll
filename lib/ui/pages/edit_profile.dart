import 'dart:convert';
import 'dart:io' as Io;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rooforall/data/provider/user_provider.dart';
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
  TextEditingController _textEditingControllerPassword =
      TextEditingController();
  final _scaffoldGlobalKey = GlobalKey<ScaffoldState>();
  bool loading = false;
  bool _validName = true;
  bool _validEmail = true;
  File _imageProfile;
  bool _mailValid = true;
  bool isLoadingImage = false;
  final picker = ImagePicker();

  updateData(BuildContext context) {
    setState(() {
      _textEditingControllerUsername.text.isEmpty
          ? _validName = false
          : _validName = true;
      _textEditingControllerPassword.text.isEmpty
          ? _validEmail = false
          : _validEmail = true;
    });

    if (_validEmail && _validName) {
      final userProvider = Provider.of<UserProvider>(context);

      userProvider.editProfileUser(
        username: _textEditingControllerUsername.text,
        password: _textEditingControllerPassword.text,
      );
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

  Future getProfileImage() async {
    File image;
    image = await ImagePicker.pickImage(source: ImageSource.camera);
    final bytes = await Io.File(image.path).readAsBytes();
    String img64 = base64Encode(bytes);
    print("IMAGEEEE ${img64.substring(0, 100)}");
    setState(() {
      isLoadingImage = true;
      _imageProfile = image;
    });
  }

  Future getImage() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 50);

    if (pickedFile.path == null) {
      print("losr");
      return;
    }

    setState(() {
      isLoadingImage = true;
      _imageProfile = File(pickedFile.path);
    });
    final bytes = await Io.File(_imageProfile.path).readAsBytes();
    String img64 = base64Encode(bytes);
//    print("IMAGEEEE ${img64.substring(0, 100)}");
    print('$img64');
  }

  Future<void> retrieveLostData() async {
    final LostData response = await picker.getLostData();
    print("Lossst");
    if (response == null) {
      print("Lossst");

      return;
    }
    if (response.file != null) {
      final pickedFile =
          await picker.getImage(source: ImageSource.camera, imageQuality: 50);

      setState(() {
        if (response.type == RetrieveType.image) {
          _imageProfile = File(pickedFile.path);
        }
      });
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

    _textEditingControllerPassword.text =
        _sharePreferences.getString("userPassword");

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
                            backgroundImage: isLoadingImage
                                ? FileImage(
                                    _imageProfile,
                                  )
                                : NetworkImage(
                                    "https://cdn.pixabay.com/photo/2013/07/13/12/07/avatar-159236_640.png")),
                        InkWell(
                          onTap: getImage,
                          child: Text(
                            "Modifier image",
                            style: TextStyle(
                              color: Utils.customGreenColor,
                              fontFamily: Utils.customFont,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Nom utilisateur",
                          style: TextStyle(
                              fontFamily: Utils.customFont,
                              fontStyle: FontStyle.italic,
                              color: Utils.customPurpleColor),
                        ),
                        createProfileNameTextFormField(context),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Mot de passe",
                          style: TextStyle(
                              fontFamily: Utils.customFont,
                              fontStyle: FontStyle.italic,
                              color: Utils.customPurpleColor),
                        ),
                        createProfilePasswordTextFormField(),
                      ],
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    FlatButton(
                      onPressed: () => updateData(context),
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

  Container createProfilePasswordTextFormField() {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      child: TextField(
        style: TextStyle(
          fontFamily: Utils.customFont,
        ),
        controller: _textEditingControllerPassword,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.vpn_key,
          ),
          hintText: "Ecrire votre mot de passe",
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
          errorText: _validEmail ? null : "Mot de passe court",
        ),
      ),
    );
  }
}
