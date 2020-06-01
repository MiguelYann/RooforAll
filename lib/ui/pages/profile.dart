import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rooforall/data/provider/user_provider.dart';
import 'package:rooforall/ui/resources/utils/utils.dart';

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
    print("build profile");
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(98.0),
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                CircleAvatar(
                  radius: 45.0,
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTdn-7SHPiGEA0vsZW7e_qUqzQ4LEoMvHOVAPljSlVnxjJ9fKWl&usqp=CAU',
                  ),
                ),
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 13.0),
                    child: Text(
                      userProvider.username?? "",
                      style: TextStyle(
                        color: Utils.customPurpleColor,
                        fontWeight: FontWeight.bold,
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
                      createColums("Logements", 3),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            createButton(context),
            SizedBox(
              height: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1,
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
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Utils.customPurpleColor,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ],
        ),
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

  createButton(BuildContext context) {
    return createButtonTitleAndFunction(
      context,
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

createButtonTitleAndFunction(BuildContext context,
    {String title, Function performFunction}) {
  return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: Utils.customPurpleColor),
        borderRadius: BorderRadius.circular(6),
      ),
      width: MediaQuery.of(context).size.width / 1,
      height: 76,
      child: FlatButton(
        onPressed: performFunction,
        child: Text(
          title,
          style: TextStyle(
            fontFamily: Utils.customFont,
            color: Utils.customPurpleColor,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ));
}
