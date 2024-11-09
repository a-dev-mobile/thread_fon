// app.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Импорт необходимых пакетов
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:threadfon/app/language/language_bloc.dart'; // Новый импорт
import 'package:threadfon/app/theme/theme.dart';
import 'package:threadfon/app/theme/theme_bloc.dart';
import 'package:threadfon/core/services/api_service/api_service.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';
// Импортируем ValueListenableBuilderN
import 'package:threadfon/features/thread_type_selection/views/thread_type_selection_screen.dart';
import 'package:threadfon/localization/l10n_extension.dart';
import 'package:threadfon/localization/generated/l10n.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.enumLang, required this.themeMode});
  final EnumLang enumLang;
  final ThemeMode themeMode;
  @override
  Widget build(BuildContext context) {
    final apiService = context.read<ApiService>();
    final storage = context.read<LocalStorage>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) =>
              ThemeBloc(storage: storage, themeMode: themeMode),
        ),
        BlocProvider(
          lazy: false,
          create: (context) =>
              LanguageBloc(storage: storage, enumLang: enumLang),
        ),
      ],
      child: const _ThreadApp(),
    );
  }
}

class _ThreadApp extends StatelessWidget {
  const _ThreadApp();

  @override
  Widget build(BuildContext context) {
    final languageState = context.watch<LanguageBloc>().state;
    final themeState = context.watch<ThemeBloc>().state;

    return MaterialApp(
      onGenerateTitle: (BuildContext context) => context.l10n.app_name,
      debugShowCheckedModeBanner: false,
      //
      themeMode: themeState.themeMode,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GeneratedLocalization.delegate,
        AppLocalizationDelegate(),
      ],
      supportedLocales: GeneratedLocalization.delegate.supportedLocales,
      locale: Locale(languageState.enumLang.name),

      //
      home: ThreadTypeSelectionScreen(),
    );
  }
}
