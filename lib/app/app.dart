import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:threadfon/config/theme/app_theme.dart';
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
  Widget build(BuildContext context) {
    return BlocBuilder<ToggleThemeCubit, bool>(
      builder: (context, isDark) => BlocBuilder<ToggleLangCubit, String>(
        builder: (context, langCode) => ScreenUtilInit(
          designSize: const Size(360, 960), // как в Figma
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) => MaterialApp(
            builder: (context, widget) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1)),
                child: widget!,
              );
            },

            onGenerateTitle: (BuildContext context) => Localization.of(context).app_name,
            debugShowCheckedModeBanner: false,
            //
            themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
            theme: AppTheme.lightThemeData(context),
            darkTheme: AppTheme.darkThemeData(context),
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
            home: const ThreadsWrapperPage(), // Установка первой страницы
            // Если у вас есть маршруты, вы можете добавить их здесь
            // Например:
            // routes: {
            //   '/threads': (context) => const ThreadsWrapperPage(),
            //   // другие маршруты
            // },
          ),
        ),
      ),
    );
  }
}
