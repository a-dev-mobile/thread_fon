import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';

import 'package:threadfon/app/language/language_bloc.dart';
import 'package:threadfon/core/constant/enum_navigation.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';
import 'package:threadfon/core/widgets/my_load_widget.dart';
import 'package:threadfon/features/splash/bloc/splash_bloc.dart';
import 'package:threadfon/features/thread_type_selection/views/thread_type_selection_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const name = 'Splash';
  static const path = '/splash';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => SplashBloc(
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
      listener: (context, state) {
        if (state.enumNavigationStatus == EnumNavigationStatus.navigation) {
          context.pushNamed(ThreadTypeSelectionScreen.name);
        }
      },
      child: MyLoadWidget(),
    );
  }
}
