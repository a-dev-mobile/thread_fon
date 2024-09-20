import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class BtnLargePrimary extends StatelessWidget {
  const BtnLargePrimary({Key? key, required this.text, required this.onClick})
      : super(key: key);
  final String text;
  final Function() onClick;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDarkMode = brightness == Brightness.dark;

    final textStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
      letterSpacing: 1.25,
      color:
          isDarkMode ? ConstColor.neutral_grey_800 : ConstColor.neutral_white,
    );
    final buttonStyle = ElevatedButton.styleFrom(
      primary: Theme.of(context).primaryColor,
      shape: const StadiumBorder(),
      side: const BorderSide(width: 0.5, color: ConstColor.neutral_grey_400),
    );

    return Padding(
      padding: const EdgeInsets.all(8),
      child: ElevatedButton(
        onPressed: onClick,
        style: buttonStyle,
        child: Text(
          text.toUpperCase(),
          style: textStyle,
        ),
      ),
    );
  }
}
