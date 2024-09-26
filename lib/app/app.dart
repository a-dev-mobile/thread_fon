import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:threadfon/app/flex_theme.dart';
import 'package:threadfon/modules/setting/cubit/toggle_lang_cubit.dart';
import 'package:threadfon/modules/setting/cubit/toggle_theme_cubit.dart';
import 'package:threadfon/modules/threads/threads_wrapper_page.dart';
import 'package:threadfon/src/common/localization/localization.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ToggleThemeCubit(),
          ),
          BlocProvider(
            create: (context) => ToggleLangCubit(),
          ),
        ],
        child: const _ThreadFonApp(),
      );
}

class _ThreadFonApp extends StatelessWidget {
  const _ThreadFonApp();

  @override
  Widget build(BuildContext context) => BlocBuilder<ToggleThemeCubit, bool>(
        builder: (context, isDark) => BlocBuilder<ToggleLangCubit, String>(
          builder: (context, langCode) => MaterialApp(
            builder: (context, widget) => MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
              child: widget!,
            ),

            onGenerateTitle: (context) => Localization.of(context).app_name,
            debugShowCheckedModeBanner: false,
            //
            themeMode: ThemeMode.dark,
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
            locale: Locale(langCode),
            //
            home: const ThreadsWrapperPage(),
          ),
        ),
      );
}
