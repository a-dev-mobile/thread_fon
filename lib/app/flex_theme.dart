import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// FlexTheme Singleton class
class FlexTheme {
  factory FlexTheme() => _internalSingleton;
  FlexTheme._internal();

  static final FlexTheme _internalSingleton = FlexTheme._internal();

  /// *---* [Light Theme] *---*
  static ThemeData lightThemeData() => FlexThemeData.light(
      scheme: FlexScheme.ebonyClay,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 7,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 10,
        blendOnColors: false,
        useTextTheme: true,
        alignedDropdown: true,
        useInputDecoratorThemeInDialogs: true,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: false,
      // To use the Playground font, add GoogleFonts package and uncomment
      fontFamily: GoogleFonts.montserrat().fontFamily,
    );

  /// *---* [Dark Theme] *---*
  static ThemeData darkThemeData() {
    return FlexThemeData.dark(
      scheme: FlexScheme.ebonyClay,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 13,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 20,
        useTextTheme: true,
        alignedDropdown: true,
        useInputDecoratorThemeInDialogs: true,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: false,
      // To use the Playground font, add GoogleFonts package and uncomment
      fontFamily: GoogleFonts.montserrat().fontFamily,
    );
// If you do not have a themeMode switch, uncomment this line
// to let the device system mode control the theme mode:
// themeMode: ThemeMode.system,
  }
}
