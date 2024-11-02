// language_notifier.dart
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageNotifier extends InheritedNotifier<ValueNotifier<String>> {
  LanguageNotifier({
    required String initialLocale,
    required super.child,
    super.key,
  }) : super(
          notifier: ValueNotifier<String>(initialLocale),
        );

  // Метод для доступа к текущему языку с обновлением виджета
  static String watch(BuildContext context) {
    final notifier = LanguageNotifier.of(context);
    assert(notifier != null, 'No LanguageNotifier found in context');
    return notifier!.value;
  }

  // Метод для доступа к LanguageNotifier без обновления виджета
  static LanguageNotifier read(BuildContext context) {
    final result = context
        .getElementForInheritedWidgetOfExactType<LanguageNotifier>()
        ?.widget as LanguageNotifier?;
    assert(result != null, 'No LanguageNotifier found in context');
    return result!;
  }

  // Метод для доступа к ValueNotifier<String> из контекста
  static ValueNotifier<String>? of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<LanguageNotifier>();
    assert(result != null, 'No LanguageNotifier found in context');
    return result?.notifier;
  }

  // Метод для установки конкретного языка и сохранения в SharedPreferences
  Future<void> setLocale(String locale) async {
    notifier?.value = locale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', locale);
  }

  // Метод для загрузки языка из SharedPreferences
  static Future<String> loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('locale') ??
        PlatformDispatcher.instance.locale.languageCode;
  }
}
