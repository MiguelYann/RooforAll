import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rooforall/data/provider/user_provider.dart';
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
  bool isViewer = false;
  SharedPreferences.getInstance().then((prefs) {

    var darkModeOn = prefs.getBool('darkMode') ?? true;
    String tokenId = prefs.get("token");
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<ThemeNotif>.value(
            value: ThemeNotif(darkModeOn ? Utils.darktheme : Utils.lightTheme),
          ),
          ChangeNotifierProvider.value(value: View(true)),
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
    SharedPreferences.getInstance().then((pref) => {
      if (pref.getBool("seen") == null) {
        pref.setBool("seen", true)
      }
      else {
        seen = pref.getBool("seen")

      }


    });
    super.initState();

    // final seenDatas = Provider.of<View>(context, listen: false);
    // final vuee = seenDatas.vue;

    // print("Initials state $vuee");

    // seenDatas.changeView();
    // print("Initials state $vuee");

    // print('Hello');
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
    // print("Buuil");
    //     final seenBuild = Provider.of<View>(context, listen: false);

    // print("finished ${seenBuild.vue}");

    final user = Provider.of<UserProvider>(context);
    print("TOKEN ${user.token}");
    final themeNotif = Provider.of<ThemeNotif>(context);
    return MaterialApp(
        routes: {
          Login.routeName: (_) => Login(),
          Home.routeName: (BuildContext context) => Home(),
          BottomNavigation.routeName: (BuildContext context) =>
              BottomNavigation(),
        },
        title: 'Flutter Defmofd',
        theme: themeNotif.getTheme(),
        home: user.token == null ? seen ? Login(): LandingScreen() : BottomNavigation());
  }
}
