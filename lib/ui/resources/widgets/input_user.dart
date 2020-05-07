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
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              style: BorderStyle.solid,
              color: Utils.colorFromHex("#00BFA6"),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            gapPadding: 20),
        labelText: labelInput,
        suffixIcon: InkWell(
          onTap: setVisiblePassword,
          child: Icon(suffixIconIten),
        ),
        prefixIcon: Icon(prefixiconItem),
      ),
    );
  }
}
