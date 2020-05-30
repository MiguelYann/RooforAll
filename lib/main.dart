import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rooforall/data/provider/user_provider.dart';
import 'package:rooforall/ui/pages/profile.dart';
import 'package:rooforall/ui/pages/setting.dart';
import 'package:rooforall/ui/resources/utils/theme.dart';
import 'package:rooforall/ui/resources/utils/theme_notif.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    bool isView = prefs.getBool("seen");
    print("is view $isView");
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
  bool seen = false;

  @override
  void initState() {
    print("Initial");

    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('state = $state');

    print('App life Cycle');
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    print('FINISHED');
  }

  @override
  Widget build(BuildContext context) {
    print("Build");

    final user = Provider.of<UserProvider>(context);
//    print("TOKEN ${user.token}");
//    print("Seen $seen");
    final themeNotif = Provider.of<ThemeNotif>(context);
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
              if (snapshot.data.getBool("seen") == true ) {
                if(user.token != null) {
                  print(user.token);
                  return BottomNavigation();
                }
                return Login();
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
