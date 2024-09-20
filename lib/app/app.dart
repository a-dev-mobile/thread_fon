import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/theme/app_theme.dart';
import '../modules/setting/cubit/toggle_lang_cubit.dart';
import '../modules/setting/cubit/toggle_theme_cubit.dart';

import 'routes/route.gr.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

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
  const _ThreadFonApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _appRouter = AppRouter();

    return BlocBuilder<ToggleThemeCubit, bool>(
      builder: (context, isDark) => BlocBuilder<ToggleLangCubit, String>(
        builder: (context, langCode) => ScreenUtilInit(
          designSize: const Size(360, 960), // as figma
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context) => MaterialApp.router(
            builder: (context, widget) {
              ScreenUtil.setContext(context);

              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
                child: widget!,
              );
            },

            onGenerateTitle: (BuildContext context) =>
                AppLocalizations.of(context).app_name,
            debugShowCheckedModeBanner: false,
            //
            themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
            theme: AppTheme.lightThemeData(context),
            darkTheme: AppTheme.darkThemeData(context),
            //
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: Locale(langCode),
            //
            routerDelegate: _appRouter.delegate(),
            routeInformationParser: _appRouter.defaultRouteParser(),
          ),
        ),
      ),
    );
  }
}
