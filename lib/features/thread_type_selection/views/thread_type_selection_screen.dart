// Package imports:

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threadfon/app/language/language_bloc.dart';
import 'package:threadfon/app/theme/theme_bloc.dart';
import 'package:threadfon/core/constant/enum_screen_status.dart';
import 'package:threadfon/core/constant/enum_status.dart';
import 'package:threadfon/core/constant/enum_thread_type.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';
import 'package:threadfon/core/widgets/my_error_widget.dart';
import 'package:threadfon/core/widgets/my_load_widget.dart';
import 'package:threadfon/features/diameter_selection/views/metric_diameter_screen.dart';
import 'package:threadfon/features/thread_type_selection/bloc/thread_type_bloc.dart';

import 'package:threadfon/features/thread_type_selection/widgets/thread_type_choice_card.dart';
import 'package:threadfon/localization/generated/l10n.dart';
import 'package:threadfon/localization/l10n.dart';
import 'package:threadfon/localization/localization.dart';

class ThreadTypeSelectionScreen extends StatelessWidget {
  const ThreadTypeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {


    return BlocProvider(
      create: (context) => ThreadTypeBloc(
        localStorage: context.read<LocalStorage>(),
        languageBloc: context.read<LanguageBloc>(), 
      )..load(),
      child: const _ThreadTypeSelectionView(),
    );
  }
}

class _ThreadTypeSelectionView extends StatelessWidget {
  const _ThreadTypeSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ThreadTypeBloc>();
    final l = context.l10n;

    switch (bloc.state.status) {
      case EnumStatus.init:
      case EnumStatus.load:
      case EnumStatus.prepareNavigating:
        return const MyLoadWidget();

      case EnumStatus.error:
        final errorMsg = bloc.state.errorMsg ?? 'An error occurred';
        return MyErrorWidget(
          errorMsg: errorMsg,
          onRetry: () => bloc.load(),
        );

      case EnumStatus.success:
        return Scaffold(
          appBar: AppBar(
            title: Text(l.thread_type),
          ),
          floatingActionButton: FloatingActionButton(onPressed: () {
            context.read<LanguageBloc>().toggle();
            context.read<ThemeBloc>().toggle();
          }),
          body: Column(
            children: bloc.state.threadTypes.map((threadType) {
              return Expanded(
                child: ThreadTypeChoiceCard(
                  onTap: () => bloc.updateUserSelection(threadType),
                  svgAssetPath: threadType.svgAssetPath,
                  label: threadType.enumThreadType == EnumThreadType.f
                      ? l.internal_thread
                      : l.external_thread,
                ),
              );
            }).toList(),
          ),
        );

      default:
        return const SizedBox.shrink();
    }
  }
}
