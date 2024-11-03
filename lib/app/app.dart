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
import 'package:threadfon/core/widgets/future_builder_n.dart';
import 'package:threadfon/core/widgets/value_listenable_builder_n.dart'; // Импортируем ValueListenableBuilderN
import 'package:threadfon/features/thread_type_selection/views/thread_type_selection_screen.dart';
import 'package:threadfon/localization/localization.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final apiService = context.read<ApiService>();
    final storage = context.read<LocalStorage>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) => ThemeBloc(storage: storage)..load(),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => LanguageBloc(storage: storage)..load(),
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
    final languageBloc = context.watch<LanguageBloc>();
    final themeBloc = context.watch<ThemeBloc>();

    return MaterialApp(
      onGenerateTitle: (context) => Localization.of(context).app_name,
      debugShowCheckedModeBanner: false,
      //
      themeMode: themeBloc.state.themeMode,
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
      locale: Locale(languageBloc.state.enumLang!.name),

      //
      home: const ThreadTypeSelectionScreen(),
    );
  }
}
