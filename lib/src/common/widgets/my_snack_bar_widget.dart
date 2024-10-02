import 'package:flutter/material.dart';
import 'package:threadfon/src/common/constant/colors.dart';
// Package imports:

import 'package:threadfon/src/common/styles/app_text_style.dart';

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
    margin: const EdgeInsets.only(bottom: 120),
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
