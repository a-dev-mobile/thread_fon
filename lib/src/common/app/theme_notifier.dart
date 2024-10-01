import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends InheritedNotifier<ValueNotifier<ThemeMode>> {
  ThemeNotifier({
    required ThemeMode initialMode,
    required super.child,
    super.key,
  }) : super(
          notifier: ValueNotifier<ThemeMode>(initialMode),
        );

  // Метод для доступа к ValueNotifier<ThemeMode> из контекста
  static ValueNotifier<ThemeMode>? of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<ThemeNotifier>();
    assert(result != null, 'No ThemeNotifier found in context');
    return result?.notifier;
  }

  // Новый метод для доступа к ThemeNotifier
  static ThemeNotifier? ofNotifier(BuildContext context) => context.dependOnInheritedWidgetOfExactType<ThemeNotifier>();

  // Метод для установки конкретной темы и сохранения в SharedPreferences
  Future<void> setTheme(ThemeMode mode) async {
    notifier?.value = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme_mode', mode.toString());
  }

  // Метод для переключения темы и сохранения в SharedPreferences
  Future<void> toggleTheme() async {
    if (notifier!.value == ThemeMode.dark) {
      await setTheme(ThemeMode.light);
    } else {
      await setTheme(ThemeMode.dark);
    }
  }

  // Метод для загрузки темы из SharedPreferences
  static Future<ThemeMode> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeString = prefs.getString('theme_mode') ?? 'ThemeMode.light';
    return ThemeMode.values.firstWhere(
      (mode) => mode.toString() == themeString,
      orElse: () => ThemeMode.light,
    );
  }
}
