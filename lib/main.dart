import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rooforall/ui/pages/login.dart';
import 'package:rooforall/ui/resources/utils/theme.dart';
import 'package:rooforall/ui/resources/utils/theme_notif.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ui/pages/home.dart';
import 'ui/resources/utils/utils.dart';
import 'ui/resources/widgets/bottom_navigation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((prefs){
    var darkModeOn = prefs.getBool('darkMode') ?? true;
    runApp(
      ChangeNotifierProvider<ThemeNotif>(
        create: (_) => ThemeNotif(darkModeOn ? darkTheme : lightTheme),
        child: MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotif = Provider.of<ThemeNotif>(context);
    return MaterialApp(
        routes: {
          Home.routeName: (BuildContext context) => Home(),
          BottomNavigation.routeName: (BuildContext context) => BottomNavigation()
        },
        title: 'Flutter Demo',
        theme: themeNotif.getTheme(),
        home: Login());
  }
}
