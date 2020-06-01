import 'package:day_night_switch/day_night_switch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rooforall/ui/resources/utils/theme_notif.dart';
import 'package:rooforall/ui/resources/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/widgets.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var _darkTheme = true;

  @override
  Widget build(BuildContext context) {
    print("Build setting");
    final themeNotifier = Provider.of<ThemeNotif>(context);
    _darkTheme = (themeNotifier.getTheme() == Utils.darktheme);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: !_darkTheme ? Utils.customPurpleColor : Colors.black,
        title: Text(
          'Parametres',
          style: TextStyle(
            color: Colors.white,
            fontFamily: Utils.customFont,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text(
              !_darkTheme ? 'Passer en mode Nuit' : "Passer en mode Clair ",
              style: TextStyle(
                fontFamily: Utils.customFont,
                color: !_darkTheme ? Utils.customPurpleColor : Colors.white,
                fontWeight: FontWeight.bold
              ),
            ),
            contentPadding: const EdgeInsets.only(left: 16.0),
            trailing: Transform.scale(
              scale: 0.4,
              child: DayNightSwitch(
                moonColor: Utils.customGreenColor,
                dayColor: Colors.grey,
                sunColor: Utils.customPurpleColor,
                nightColor: Colors.white10,
                value: _darkTheme,
                onChanged: (val) {
                  setState(() {
                    _darkTheme = val;
                  });
                  onThemeChanged(val, themeNotifier);
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  void onThemeChanged(bool value, ThemeNotif themeNotif) async {
    (value)
        ? themeNotif.setTheme(Utils.darktheme)
        : themeNotif.setTheme(Utils.lightTheme);
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', value);
  }
}
