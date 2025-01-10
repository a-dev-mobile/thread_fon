import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:threadfon/app/language/language_bloc.dart';
import 'package:threadfon/core/constant/enum_navigation_status.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';
import 'package:threadfon/core/widgets/loading_widget.dart';
import 'package:threadfon/features/01_splash/bloc/splash_bloc.dart';
import 'package:threadfon/features/02_thread_type_selection/views/thread_type_selection_screen.dart';
import 'package:threadfon/main.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const String name = 'Splash';
  static const String path = '/splash';

  @override
  Widget build(BuildContext context) {
    // Логируем событие открытия приложения
    analytics.logEvent(name: 'app_open');

    return BlocProvider(
      lazy: false,
      create: (BuildContext context) => SplashBloc(
        storage: context.read<LocalStorage>(),
        languageBloc: context.read<LanguageBloc>(),
      )..load(),
      child: const _SplashView(),
    );
  }
}

class _SplashView extends StatelessWidget {
  const _SplashView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (BuildContext context, SplashState state) {
        if (state.enumNavigationStatus == EnumNavigationStatus.navigation) {
          context.goNamed(ThreadTypeSelectionScreen.name);
        }
      },
      child: const LoadingWidget(),
    );
  }
}
