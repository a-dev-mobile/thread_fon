import 'package:flutter/material.dart';

import 'package:threadfon/config/styles/app_text_style.dart';
import 'package:threadfon/core/constants/colors.dart';

class BtnListSwitch extends StatelessWidget {
  const BtnListSwitch({
    required this.value,
    required this.onChanged,
    required this.text,
    super.key,
    this.leading,
  });
  final bool value;
  final Function(bool value) onChanged;
  final Widget? leading;
  final String text;
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SwitchListTile(
      inactiveThumbColor:
          isDarkMode ? ConstColor.neutral_grey_800 : ConstColor.neutral_white,
      activeColor:
          isDarkMode ? ConstColor.neutral_grey_800 : ConstColor.neutral_white,

      activeTrackColor:
          isDarkMode ? ConstColor.primary_301 : ConstColor.primary_500,
      // inactiveTrackColor: Colors.yellow,
      title: Text(
        text,
        style: AppTextStyle.BODY_SEMI_BOLD(),
      ),
      onChanged: onChanged,
      secondary: leading,
      value: value,
    );
  }
}
