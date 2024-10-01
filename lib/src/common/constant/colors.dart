// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class ConstColor {
  static const Color primary_800 = Color(0xFF2D5385);
  static const Color primary_500 = Color(0xFF2F80ED);
  static const Color primary_301 = Color(0xFF82B3F4);
  static const Color primary_100 = Color(0xFFD5E6FB);

  static const Color neutral_grey_1000 = Color(0xFF161F27);
  static const Color neutral_grey_900 = Color(0xFF1F2933);
  static const Color neutral_grey_200 = Color(0xFFCBD2D9);
  static const Color neutral_grey_800 = Color(0xFF323F4B);
  static const Color neutral_grey_400 = Color(0xFF7B8794);
  static const Color neutral_grey_100 = Color(0xFFE3E7EB);
  static const Color neutral_white = Color(0xFFffffff);
}

const Map<int, Color> mapSwatchLight = {
  50: Color.fromRGBO(47, 128, 237, .1),
  100: Color.fromRGBO(47, 128, 237, .2),
  200: Color.fromRGBO(47, 128, 237, .3),
  300: Color.fromRGBO(47, 128, 237, .4),
  400: Color.fromRGBO(47, 128, 237, .5),
  500: Color.fromRGBO(47, 128, 237, .6),
  600: Color.fromRGBO(47, 128, 237, .7),
  700: Color.fromRGBO(47, 128, 237, .8),
  800: Color.fromRGBO(47, 128, 237, .9),
  900: Color.fromRGBO(47, 128, 237, 1),
};
const Map<int, Color> mapSwatchDark = {
  // ignore: double-literal-format
  50: Color.fromRGBO(130, 179, 244, .1),
  100: Color.fromRGBO(130, 179, 244, .2),
  200: Color.fromRGBO(130, 179, 244, .3),
  300: Color.fromRGBO(130, 179, 244, .4),
  400: Color.fromRGBO(130, 179, 244, 0.5),
  500: Color.fromRGBO(130, 179, 244, 0.6),
  600: Color.fromRGBO(130, 179, 244, 0.7),
  700: Color.fromRGBO(130, 179, 244, .8),
  800: Color.fromRGBO(130, 179, 244, .9),
  900: Color.fromRGBO(130, 179, 244, 1),
};
Color hexToColor(String hex) {
  assert(
    RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex),
    'hex color must be #rrggbb or #rrggbbaa',
  );

  return Color(
    int.parse(hex.substring(1), radix: 16) +
        (hex.length == 7 ? 0xff000000 : 0x00000000),
  );
}

// for primarySwatch theme
//primary_301
const primaryDark = 0xFF82B3F4;
//primary_500
const primaryLight = 0xFF2F80ED;
