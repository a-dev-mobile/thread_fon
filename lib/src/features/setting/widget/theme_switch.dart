import 'package:flutter/material.dart';
import 'package:threadfon/src/common/notifier/theme_notifier.dart';
import 'package:threadfon/src/common/localization/localization.dart';

class ThemeSwitchWidget extends StatelessWidget {
  const ThemeSwitchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Используем watch для получения текущего ThemeMode и обновления виджета при изменении темы
    final themeMode = ThemeNotifier.watch(context);

    return SwitchListTile(
      title: Text(
        Localization.of(context).dark_theme,
      ),
      value: themeMode == ThemeMode.dark,
      onChanged: (value) {
        // Используем read для изменения темы без обновления этого виджета
        ThemeNotifier.read(context).setTheme(
          value ? ThemeMode.dark : ThemeMode.light,
        );
      },
    );
  }
}
