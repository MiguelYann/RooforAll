import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rooforall/ui/resources/utils/theme_notif.dart';
import 'package:rooforall/ui/resources/utils/utils.dart';

class UserInput extends StatelessWidget {
  final TextEditingController textInput;
  final String labelInput;
  final IconData prefixiconItem;
  final IconData suffixIconIten;
  final bool hiddenPassword;
  final Function setVisiblePassword;

  UserInput({
    @required this.textInput,
    @required this.prefixiconItem,
    this.suffixIconIten,
    this.hiddenPassword,
    this.setVisiblePassword,
    @required this.labelInput,
  });

  @override
  Widget build(BuildContext context) {
      var _darkTheme = true;

     final themeNotifier = Provider.of<ThemeNotif>(context);
    _darkTheme = (themeNotifier.getTheme() == Utils.darktheme);
    return TextField(
      obscureText: hiddenPassword ?? true,
      controller: textInput,
      decoration: InputDecoration(
        hintText: labelInput,
        hintStyle: TextStyle(
            color: _darkTheme ? Colors.white:  Utils.customPurpleColor,
            fontFamily: Utils.customFont,
            fontSize: 9),
        suffixIcon: InkWell(
          onTap: setVisiblePassword,
          child: Icon(
            suffixIconIten,
            color: _darkTheme ? Colors.white:  Utils.customPurpleColor,
          ),
        ),
        prefixIcon: Icon(
          prefixiconItem,
            color: _darkTheme ? Colors.white:  Utils.customPurpleColor,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: _darkTheme ?Colors.white:  Utils.customPurpleColor,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: _darkTheme ? Colors.white:  Utils.customPurpleColor,
          ),
        ),
      ),
    );
  }
}
