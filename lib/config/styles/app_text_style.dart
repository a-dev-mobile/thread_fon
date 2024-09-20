// ignore_for_file: non_constant_identifier_names

import 'dart:math';

import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppTextStyle {
  // static final BuildContext _context = AppGlobal.getContext();

  static TextStyle H3_BOLD([Color? colorText]) => TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20.sp,
        color: colorText,
        letterSpacing: 0.15,
      );

  static TextStyle H3_REGULAR({Color? colorText, BuildContext? context}) {
    var isTable = false;

    if (context != null) {
      isTable = isTablet(context);
    }

    return TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: isTable ? 10.sp : 20.sp,
      color: colorText,
      letterSpacing: 0.15,
    );
  }

  static TextStyle H2({Color? colorText, BuildContext? context}) {
    var isTable = false;

    if (context != null) {
      isTable = isTablet(context);
    }

    return TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: isTable ? 15.sp : 25.sp,
      color: colorText,
      height: 1.25,
    );
  }

  static TextStyle BODY_SEMI_BOLD({Color? colorText}) => TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16.sp,
        color: colorText,
        height: 1.5,
      );

  static TextStyle LABEL_EXTRA_BOLD({Color? colorText}) =>
      TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp, color: colorText);

  static TextStyle LABEL_REGULAR({Color? colorText, BuildContext? context}) {
    var isTable = false;

    if (context != null) {
      isTable = isTablet(context);
    }

    return TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: isTable ? 6.sp : 12.sp,
      color: colorText,
    );
  }

  static TextStyle LABEL_SEMI_BOLD([Color? textColor]) =>
      TextStyle(fontWeight: FontWeight.w600, fontSize: 12.sp, color: textColor);

  static TextStyle BUTTON() => TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 15.sp,
        letterSpacing: 1.25,
      );

  static TextStyle CAPTION({Color? colorText, BuildContext? context}) {
    var isTable = false;

    if (context != null) {
      isTable = isTablet(context);
    }

    return TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: isTable ? 7.sp : 14.sp,
      letterSpacing: 0.2,
      color: colorText,
    );
  }

  static TextStyle BODY_REGULAR([Color? colorText]) => TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 16.sp,
        color: colorText,
      );

  static bool isTablet(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final diagonal =
        sqrt((size.width * size.width) + (size.height * size.height));

    /*
    print(
      'size: ${size.width}x${size.height}\n'
      'pixelRatio: ${query.devicePixelRatio}\n'
      'pixels: ${size.width * query.devicePixelRatio}x${size.height * query.devicePixelRatio}\n'
      'diagonal: $diagonal'
    );
    */

    final isTablet = diagonal > 1100.0;

    return isTablet;
  }
}
