import 'package:flutter/material.dart';

class Utils {
  static Color colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }

  static const Color customGreenColor = const Color(0xFF00BFA6);
  static const Color customPurpleColor = const Color(0xFF29264E);
  static const String customFont = "SFPro";
}
