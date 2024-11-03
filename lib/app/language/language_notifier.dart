// language_notifier.dart
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum EnumLang {
  ru,
  en,
}

class LanguageNotifier extends InheritedNotifier<ValueNotifier<EnumLang>> {
  LanguageNotifier({
    required EnumLang initialLocale,
    required Widget child,
    Key? key,
  }) : super(
          notifier: ValueNotifier<EnumLang>(initialLocale),
          child: child,
          key: key,
        );

  /// Метод для доступа к текущему языку с обновлением виджета
  static EnumLang watch(BuildContext context) {
    final notifier = LanguageNotifier.of(context);
    assert(notifier != null, 'No LanguageNotifier found in context');
    return notifier!.value;
  }

  /// Метод для доступа к LanguageNotifier без обновления виджета
  static LanguageNotifier read(BuildContext context) {
    final result = context.getElementForInheritedWidgetOfExactType<LanguageNotifier>()?.widget as LanguageNotifier?;
    assert(result != null, 'No LanguageNotifier found in context');
    return result!;
  }

  /// Метод для доступа к ValueNotifier<EnumLang> из контекста
  static ValueNotifier<EnumLang>? of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<LanguageNotifier>();
    assert(result != null, 'No LanguageNotifier found in context');
    return result?.notifier;
  }

  /// Метод для установки конкретного языка и сохранения в SharedPreferences
  Future<void> setLocale(EnumLang locale) async {
    notifier?.value = locale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', locale.name);
  }

  /// Метод для загрузки языка из SharedPreferences
  /// Если значение не сохранено, устанавливаем 'en' и сохраняем его
  static Future<EnumLang> loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final localeString = prefs.getString('locale');
    if (localeString != null) {
      // Пытаемся найти соответствующее значение EnumLang
      return EnumLang.values.firstWhere(
        (e) => e.name == localeString,
        orElse: () => EnumLang.en, // Значение по умолчанию
      );
    }
    // Если значение не сохранено, используем системный язык
    final systemLocale = PlatformDispatcher.instance.locale.languageCode;
    return EnumLang.values.firstWhere(
      (e) => e.name == systemLocale,
      orElse: () => EnumLang.en,
    );
  }

  /// Метод для перебора локали (переключение на следующий язык)
  Future<void> toggleLocale() async {
    final currentLocale = notifier?.value ?? EnumLang.en;
    final nextLocale = EnumLang.values[(currentLocale.index + 1) % EnumLang.values.length];
    await setLocale(nextLocale);
  }
}
