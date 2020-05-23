import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rooforall/ui/resources/utils/theme_notif.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ui/pages/home.dart';
import 'ui/pages/landing.dart';
import 'ui/pages/login.dart';
import 'ui/resources/utils/utils.dart';
import 'ui/resources/widgets/bottom_navigation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((prefs) {
    var darkModeOn = prefs.getBool('darkMode') ?? true;
    runApp(
      ChangeNotifierProvider<ThemeNotif>(
        create: (_) =>
            ThemeNotif(darkModeOn ? Utils.darktheme : Utils.lightTheme),
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
  bool _isView;
  Future<bool> checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isView = prefs.getBool('seen') ?? false;

    if (_isView) {
      print('VUE');
      return _isView;
    } else {
      prefs.setBool('seen', true);
      print('pas VUE');

      print(prefs.get('seen'));
      _isView = prefs.getBool('seen');

      return _isView;
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    print(_isView);
    checkFirstSeen().then((value) => _isView = value);
    print('Value future${checkFirstSeen()}');
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
    final themeNotif = Provider.of<ThemeNotif>(context);
    return MaterialApp(
      routes: {
        Login.routeName: (_) => Login(),
        Home.routeName: (BuildContext context) => Home(),
        BottomNavigation.routeName: (BuildContext context) =>
            BottomNavigation(),
      },
      title: 'Flutter Demo',
      theme: themeNotif.getTheme(),
      home: _isView ?? false ? Login() : LandingScreen(),
    );
  }
}
