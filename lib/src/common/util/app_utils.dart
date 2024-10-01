import 'package:flutter/material.dart';

import 'package:threadfon/src/common/constant/common.dart';
import 'package:threadfon/src/common/util/app_log.dart';

abstract class AppUtilsString {
  static String removeDecimalZeroFormat(double n) =>
      n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);

  static String removeLastCharacter(String str) {
    var result = '';
    if ((str != '') && (str.isNotEmpty)) {
      result = str.substring(0, str.length - 1);
    }

    return result;
  }

  static String getLastCharacter(String str) {
    var result = '';
    if ((str != '') && (str.isNotEmpty)) {
      result = str.substring(str.length - 1);
    }

    return result;
  }

  static String getFirstCharacter(String str) {
    var result = '';
    if ((str != '') && (str.isNotEmpty)) {
      result = str.substring(0);
    }

    return result;
  }

  static String addZeroIsFirstDecimal(String text) =>
      AppUtilsString.getFirstCharacter(text) == '.' ? text = '0$text' : text;
}

class AppUtilsNumber {
  static String getFormatNumber(double num, int numberDigitsAfterPoint) {
// округляем, но нет удаления конечных нулей
    final num2 = num.toStringAsFixed(numberDigitsAfterPoint);
    // если нет точки возвращаем
    if (!num2.contains('.')) return num2;

    final s = num2.split('.');
    var mainResult = num2;
    // проверяем есть ли последние нули
    if (AppUtilsString.getLastCharacter(s[1]) == '0') {
      var oldString = '';
      var newString = '';
      oldString = s[1];

      for (var i = 0; i < s[1].length; i++) {
        if (AppUtilsString.getLastCharacter(oldString) == '0') {
          newString = AppUtilsString.removeLastCharacter(oldString);
        } else {
          break;
        }
        oldString = newString;
      }
// действия, если после ни чего ни осталось оставляем split 0
      mainResult = newString.isEmpty ? s[0] : '${s[0]}.$newString';
    }

    return mainResult;
  }

  static String mmToInch(String mm) {
    final value = getFormatNumber(
      AppUtilsParse.stringToDouble(mm) / 25.4,
      ConstCommon.precisionInch,
    );

    return value;
  }

  static String inchToMm(String inch) {
    final value = getFormatNumber(
      AppUtilsParse.stringToDouble(inch) * 25.4,
      ConstCommon.precisionMm,
    );

    return value;
  }
}

class AppUtilsParse {
  static Color color(String hexCode, {double opacity = 1}) {
    try {
      return Color(int.parse(hexCode.replaceAll('#', '0xFF')))
          .withOpacity(opacity);
    } catch (e) {
      return const Color(0xFFCCCCCC).withOpacity(opacity);
    }
  }

  static double stringToDouble(String text) {
    var value = 0.0;
    try {
      value = double.parse(text);
    } catch (e) {
      logger.e(e);
    }

    return value;
  }
}
