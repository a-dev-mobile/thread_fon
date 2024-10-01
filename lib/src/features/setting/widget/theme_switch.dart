import 'package:flutter/material.dart';
import 'package:threadfon/src/common/app/theme_notifier.dart';
import 'package:threadfon/src/common/styles/app_text_style.dart';
import 'package:threadfon/src/common/localization/localization.dart';

class ThemeSwitchWidget extends StatelessWidget {
  const ThemeSwitchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Получаем экземпляр ThemeNotifier
    final themeNotifier = ThemeNotifier.ofNotifier(context);

    if (themeNotifier == null) {
      // Если ThemeNotifier не найден, можно вернуть пустой контейнер или обработать ошибку
      return Container();
    }

    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier.notifier!,
      builder: (context, themeMode, _) => SwitchListTile(
        title: Text(
          Localization.of(context).dark_theme,
          style: AppTextStyle.BODY_SEMI_BOLD(),
        ),
        onChanged: (value) {
          var newThemeMode = value ? ThemeMode.dark : ThemeMode.light;
          themeNotifier.setTheme(newThemeMode);
        },
        value: themeMode == ThemeMode.dark,
      ),
    );
  }
}
