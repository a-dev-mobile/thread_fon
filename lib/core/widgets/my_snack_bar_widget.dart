import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:threadfon/config/styles/app_text_style.dart';
import 'package:threadfon/core/constants/colors.dart';

SnackBar mySnakBarWidget({
  required BuildContext context,
  required String text,
}) {
  final brightness = Theme.of(context).brightness;
  final isDark = brightness == Brightness.dark;
  final backgroundColor =
      isDark ? ConstColor.neutral_grey_1000 : ConstColor.neutral_grey_100;

  return SnackBar(
    duration: const Duration(milliseconds: 1000),
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.only(bottom: 120.h),
    // margin: EdgeInsets.fromLTRB(0, 0, 0, 175),
    content: Text(
      text,
      textAlign: TextAlign.center,
      style: AppTextStyle.H3_REGULAR(
          // colorText: Theme.of(context).textTheme.bodyText1!.color,
          ),
    ),
    backgroundColor: backgroundColor,
  );
}
