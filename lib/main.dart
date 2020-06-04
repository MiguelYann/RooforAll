import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rooforall/data/provider/user_provider.dart';
import 'package:rooforall/ui/resources/utils/theme_notif.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

import 'ui/pages/home.dart';
import 'ui/pages/landing.dart';
import 'ui/pages/login.dart';
import 'ui/resources/utils/utils.dart';
import 'ui/resources/widgets/bottom_navigation.dart';

void main() {
  print("nooooo");
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences.getInstance().then((prefs) {
    var darkModeOn = prefs.getBool('darkMode') ?? true;
    String tokenId = prefs.get("token");
//    bool isView = prefs.getBool("seen");
//    print("is view $isView");
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<ThemeNotif>.value(
            value: ThemeNotif(darkModeOn ? Utils.darktheme : Utils.lightTheme),
          ),
          ChangeNotifierProvider.value(
              value: UserProvider(tokenId != null ? tokenId : null))
        ],
        child: MyApp(),
      ),
    );
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
  }


  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  loadWidget() async {
    return await new Future<Widget>.delayed(
        Duration(seconds: 1), () => AfterSplash());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(
          seconds: 4,
          navigateAfterSeconds: new AfterSplash(),
          title:  Text(
            'Welcome',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
          image: Image.network("https://i.imgur.com/abWzWEp.png"),
          styleTextUnderTheLoader: TextStyle(),
          photoSize: 100.0,
          loaderColor: Colors.black),
    );
  }
}

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Build");

    final user = Provider.of<UserProvider>(context);

    final themeNotif = Provider.of<ThemeNotif>(context);
    print(user.token);

    return MaterialApp(
        routes: {

          Login.routeName: (_) => Login(),
          Home.routeName: (BuildContext context) => Home(),
          BottomNavigation.routeName: (BuildContext context) =>
              BottomNavigation(),
        },
        title: 'RooforAll',
        theme: themeNotif.getTheme(),
        home: FutureBuilder(
          future: SharedPreferences.getInstance(),
          builder: (ctx, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data.getBool("seen"));
              if (snapshot.data.getBool("seen") == true) {
                if (user.token != null) {
                  print(user.token);
                  return BottomNavigation();
                } else {
                  return Login();
                }
              } else if (snapshot.data.getBool("seen") == null) {
                return LandingScreen();
              } else {
                return LandingScreen();
              }
            } else {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ));
//    user.token == null
//        ? seen ? Login() : LandingScreen()
//        : BottomNavigation(),
  }
}
