// app.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Импорт необходимых пакетов
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nested/nested.dart';
import 'package:threadfon/app/language/language_bloc.dart';
import 'package:threadfon/app/router/app_router.dart';
import 'package:threadfon/app/theme/app_theme.dart';
import 'package:threadfon/app/theme/theme_bloc.dart';
import 'package:threadfon/core/constant/enum_lang.dart'; // Новый импорт
import 'package:threadfon/core/services/connectivity/connectivity_bloc.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';
import 'package:threadfon/localization/generated/l10n.dart';
import 'package:threadfon/localization/l10n_extension.dart';

class App extends StatelessWidget {
  const App({required this.enumLang, required this.themeMode, super.key});
  final EnumLang enumLang;
  final ThemeMode themeMode;
  @override
  Widget build(BuildContext context) {
    final LocalStorage storage = context.read<LocalStorage>();

    return MultiBlocProvider(
      providers: <SingleChildWidget>[
        BlocProvider(
          lazy: false,
          create: (BuildContext context) =>
              ThemeBloc(storage: storage, themeMode: themeMode),
        ),
        BlocProvider(
          lazy: false,
          create: (BuildContext context) =>
              LanguageBloc(storage: storage, enumLang: enumLang),
        ),
        BlocProvider(
          lazy: false,
          create: (BuildContext context) => ConnectivityBloc(),
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
    final LanguageState languageState = context.watch<LanguageBloc>().state;
    final ThemeState themeState = context.watch<ThemeBloc>().state;
    final AppRouter appRouter = context.read<AppRouter>();

    return MaterialApp.router(
      onGenerateTitle: (BuildContext context) => context.l10n.app_name,
      debugShowCheckedModeBanner: false,
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
      routeInformationProvider: appRouter.router.routeInformationProvider,
      routeInformationParser: appRouter.router.routeInformationParser,
      routerDelegate: appRouter.router.routerDelegate,
    );
  }
}
