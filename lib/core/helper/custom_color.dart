import 'package:flutter/material.dart';

class CustomColor {
  static const Map<int, Color> purpleColor = {
    50: Color.fromRGBO(98, 0, 238, .1),
    100: Color.fromRGBO(98, 0, 238, .2),
    200: Color.fromRGBO(98, 0, 238, .3),
    300: Color.fromRGBO(98, 0, 238, .4),
    400: Color.fromRGBO(98, 0, 238, .5),
    500: Color.fromRGBO(98, 0, 238, .6),
    600: Color.fromRGBO(98, 0, 238, .7),
    700: Color.fromRGBO(98, 0, 238, .8),
    800: Color.fromRGBO(98, 0, 238, .9),
    900: Color.fromRGBO(98, 0, 238, 1),
  };
  static const MaterialColor purpleMaterialColor =
      MaterialColor(0xFF6200ee, purpleColor);

  static const Map<int, Color> tealColor = {
    50: Color.fromRGBO(3, 218, 197, .1),
    100: Color.fromRGBO(3, 218, 197, .2),
    200: Color.fromRGBO(3, 218, 197, .3),
    300: Color.fromRGBO(3, 218, 197, .4),
    400: Color.fromRGBO(3, 218, 197, .5),
    500: Color.fromRGBO(3, 218, 197, .6),
    600: Color.fromRGBO(3, 218, 197, .7),
    700: Color.fromRGBO(3, 218, 197, .8),
    800: Color.fromRGBO(3, 218, 197, .9),
    900: Color.fromRGBO(3, 218, 197, 1),
  };
  static const MaterialColor tealMaterialColor =
      MaterialColor(0xFF03dac5, tealColor);
}
