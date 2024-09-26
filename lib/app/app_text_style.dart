import 'package:flutter/material.dart';

abstract class AppTextStyles {
  static const FontWeight thin = FontWeight.w100;
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;

  static const TextStyle headlineLarge = TextStyle(
    fontSize: 32,
    fontWeight: regular,
    letterSpacing: 0,
    height: 40 / 32,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 28,
    fontWeight: regular,
    letterSpacing: 0,
    height: 36 / 28,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontSize: 24,
    fontWeight: regular,
    letterSpacing: 0,
    height: 32 / 24,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: regular,
    letterSpacing: 0.5,
    height: 24 / 16,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: regular,
    letterSpacing: 0.25,
    height: 20 / 14,
  );

  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: medium,
    letterSpacing: 0.1,
    height: 20 / 14,
  );
  static const TextStyle titleLarge = TextStyle(
    fontSize: 22,
    fontWeight: regular,
    letterSpacing: 0,
    height: 28 / 22,
  );
}
