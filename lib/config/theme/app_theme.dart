import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/colors.dart';

class AppTheme {
  // Private Constructor
  AppTheme._();

  static ThemeData lightThemeData(BuildContext context) =>
      ThemeData.light().copyWith(
        appBarTheme: _getAppBarTheme(isDark: false, context: context),
        // bottomAppBarColor:const MaterialColor(primaryLight, mapSwatchLight),
        brightness: Brightness.light,
        // color for overlay scroll
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: const MaterialColor(primaryLight, mapSwatchLight),
        ),
        primaryColor: ConstColor.primary_500,
        scaffoldBackgroundColor: ConstColor.neutral_white,
        textTheme: _getTextTheme(context: context, isDark: false),
        canvasColor: ConstColor.neutral_white,
        iconTheme: iconTheme(),
      );

  static IconThemeData iconTheme() =>
      const IconThemeData(color: ConstColor.neutral_grey_400);

  static ThemeData darkThemeData(BuildContext context) =>
      ThemeData.dark().copyWith(
        // bottomAppBarColor: const MaterialColor(primaryDark, mapSwatchDark),
        appBarTheme: _getAppBarTheme(isDark: true, context: context),
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: const MaterialColor(primaryDark, mapSwatchDark),
        ),
        primaryColor: ConstColor.primary_301,
        scaffoldBackgroundColor: ConstColor.neutral_grey_900,
        textTheme: _getTextTheme(context: context, isDark: true),
        canvasColor: ConstColor.neutral_grey_900,
        iconTheme: iconTheme(),
      );

  static AppBarTheme _getAppBarTheme(
      {required BuildContext context, required bool isDark}) {
    final backgroundColor =
        isDark ? ConstColor.neutral_grey_900 : ConstColor.neutral_white;
    final foregroundColor =
        isDark ? ConstColor.neutral_grey_200 : ConstColor.neutral_grey_800;

    final appBarTheme = AppBarTheme(
      backgroundColor: backgroundColor,
      elevation: 1,
      centerTitle: true,
      foregroundColor: foregroundColor,
      systemOverlayStyle: isDark
          ? SystemUiOverlayStyle.light.copyWith(
              statusBarColor: backgroundColor,
              statusBarIconBrightness: Brightness.light,
            )
          : SystemUiOverlayStyle.dark.copyWith(
              statusBarColor: backgroundColor,
              statusBarIconBrightness: Brightness.dark,
            ),
    );

    return appBarTheme;
  }

  static TextTheme _getTextTheme(
      {required BuildContext context, required bool isDark}) {
    final bodyColor =
        isDark ? ConstColor.neutral_grey_200 : ConstColor.neutral_grey_800;

    final textTheme = Theme.of(context)
        .textTheme
        .apply(fontFamily: 'montserrat', bodyColor: bodyColor);

    return textTheme;
  }
}
