// app.dart

import 'package:flutter/material.dart';
// Импорт необходимых пакетов
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:threadfon/app/language/language_notifier.dart'; // Новый импорт
import 'package:threadfon/app/theme/theme.dart';
import 'package:threadfon/app/theme/theme_notifier.dart';
import 'package:threadfon/core/widgets/future_builder_n.dart';
import 'package:threadfon/core/widgets/value_listenable_builder_n.dart'; // Импортируем ValueListenableBuilderN
import 'package:threadfon/features/thread_type_selection/views/thread_type_selection_screen.dart';
import 'package:threadfon/localization/localization.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilderN<dynamic>(
      futures: [
        ThemeNotifier.loadTheme(),    // data[0]
        LanguageNotifier.loadLocale() // data[1],
      ],
      builder: (context, data, error) {
        if (error != null) {
          return MaterialApp(
            home: Scaffold(
              body: Center(child: Text('Ошибка: $error')),
            ),
          );
        }

        final themeMode = data[0] as ThemeMode;
        final locale = data[1] as EnumLang;

        return ThemeNotifier(
          initialMode: themeMode,
          child: LanguageNotifier(
            initialLocale: locale,
            child: const _ThreadApp(),
          ),
        );
      },
      loadingWidget: const MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      ),
      errorWidget: const MaterialApp(
        home: Scaffold(
          body: Center(child: Text('Не удалось загрузить настройки')),
        ),
      ),
    );
  }
}

class _ThreadApp extends StatelessWidget {
  const _ThreadApp();

  @override
  Widget build(BuildContext context) {
    // Получаем ValueNotifier<ThemeMode> из ThemeNotifier
    final themeModeNotifier = ThemeNotifier.of(context);

    // Получаем ValueNotifier<String> из LanguageNotifier
    final languageNotifier = LanguageNotifier.of(context);

    if (themeModeNotifier == null || languageNotifier == null) {
      // Если Notifier'ы не найдены, можно вернуть пустой контейнер или обработать ошибку
      return const SizedBox.shrink();
    }

    return ValueListenableBuilderN<dynamic>(
      listenable: [themeModeNotifier, languageNotifier],
      builder: (context, values, child) {
        final themeMode = values[0] as ThemeMode;
        final locale = values[1] as EnumLang;

        return MaterialApp(
          onGenerateTitle: (context) => Localization.of(context).app_name,
          debugShowCheckedModeBanner: false,
          //
          themeMode: themeMode,
          theme: AppTheme.lightThemeData(),
          darkTheme: AppTheme.darkThemeData(),
          //
          localizationsDelegates: const <LocalizationsDelegate<Object?>>[
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            Localization.delegate,
          ],
          supportedLocales: Localization.supportedLocales,
          locale: Locale(locale.name),

          //
          home: const ThreadTypeSelectionScreen(),
        );
      },
    );
  }
}
