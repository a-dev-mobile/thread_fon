// app.dart

import 'package:flutter/material.dart';
// Импорт необходимых пакетов
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:threadfon/src/common/app/flex_theme.dart';
import 'package:threadfon/src/common/app/future_builder_n.dart';
import 'package:threadfon/src/common/app/language_notifier.dart'; // Новый импорт
import 'package:threadfon/src/common/app/theme_notifier.dart';
import 'package:threadfon/src/common/app/value_listenable_builder_n.dart'; // Импортируем ValueListenableBuilderN
import 'package:threadfon/src/common/localization/localization.dart';
import 'package:threadfon/src/features/01_selection_thread_type/view/thread_type_selection_page.dart';


class App extends StatefulWidget {
  const App({
    super.key,
  });

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  late Future<ThemeMode> _themeModeFuture;
  late Future<String> _localeFuture;

  @override
  void initState() {
    super.initState();
    _themeModeFuture = ThemeNotifier.loadTheme();
    _localeFuture = LanguageNotifier.loadLocale();
  }

  @override
  Widget build(BuildContext context) => FutureBuilderN<dynamic>(
        futures: [_themeModeFuture, _localeFuture],
        builder: (context, data, error) {
          if (error != null) {
            return MaterialApp(
              home: Scaffold(
                body: Center(child: Text('Ошибка: $error')),
              ),
            );
          }
          final themeMode = data[0] as ThemeMode;
          final locale = data[1] as String;

          return ThemeNotifier(
            initialMode: themeMode,
            child: LanguageNotifier(
              initialLocale: locale,
              child: const _ThreadFonApp(),
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

class _ThreadFonApp extends StatelessWidget {
  const _ThreadFonApp();

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
        final locale = values[1] as String;

        return MaterialApp(
          onGenerateTitle: (context) => Localization.of(context).app_name,
          debugShowCheckedModeBanner: false,
          //
          themeMode: themeMode,
          theme: FlexTheme.lightThemeData(),
          darkTheme: FlexTheme.darkThemeData(),
          //
          localizationsDelegates: const <LocalizationsDelegate<Object?>>[
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            Localization.delegate,
          ],
          supportedLocales: Localization.supportedLocales,
          locale: Locale(locale),
          //
          home: const ThreadTypeSelectionPage(),
        );
      },
    );
  }
}
