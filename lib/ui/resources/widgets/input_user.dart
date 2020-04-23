import 'package:flutter/material.dart';

class UserInput extends StatelessWidget {
  final TextEditingController textInput;
  final String labelInput;
  final IconData iconItem;

  UserInput({@required this.textInput, @required this.iconItem, @required this.labelInput});

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: textInput,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(style: BorderStyle.solid),
              borderRadius: BorderRadius.all(Radius.circular(10)),
              gapPadding: 20),
          labelText: 'Email',
          icon: Icon(iconItem),
        ));
  }
}
