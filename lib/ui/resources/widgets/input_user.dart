import 'package:flutter/material.dart';
import 'package:rooforall/ui/resources/utils/utils.dart';

class UserInput extends StatelessWidget {
  final TextEditingController textInput;
  final String labelInput;
  final IconData prefixiconItem;
  final IconData suffixIconIten;
  final bool showPassword;
  final Function setVisiblePassword;

  UserInput({
    @required this.textInput,
    @required this.prefixiconItem,
    this.suffixIconIten,
    this.showPassword,
    this.setVisiblePassword,
    @required this.labelInput,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: showPassword ?? false,
      controller: textInput,
      decoration: InputDecoration(
        helperText: labelInput,
        helperStyle: TextStyle(color: Utils.customPurpleColor, fontFamily: Utils.customFont),
        suffixIcon: InkWell(
          onTap: setVisiblePassword,
          child: Icon(suffixIconIten, color: Utils.customPurpleColor,),
        ),
        prefixIcon: Icon(prefixiconItem, color: Utils.customPurpleColor,),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              style: BorderStyle.solid,
              color: Utils.customPurpleColor,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            gapPadding: 20),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              style: BorderStyle.solid,
              color: Utils.customPurpleColor,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            gapPadding: 20),
      ),
    );
  }
}
