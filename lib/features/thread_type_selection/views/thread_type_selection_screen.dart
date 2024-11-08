// Package imports:

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threadfon/app/language/language_bloc.dart';
import 'package:threadfon/core/constant/enum_navigation.dart';
import 'package:threadfon/core/constant/enum_status.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';
import 'package:threadfon/core/widgets/blurred_overlay.dart';
import 'package:threadfon/core/widgets/my_error_widget.dart';
import 'package:threadfon/core/widgets/my_load_widget.dart';
import 'package:threadfon/features/diameter_selection/views/metric_diameter_screen.dart';
import 'package:threadfon/features/thread_type_selection/bloc/thread_type_bloc.dart';
import 'package:threadfon/features/thread_type_selection/models/thread_type_model.dart';
import 'package:threadfon/features/thread_type_selection/repositories/thread_type_repository.dart';
import 'package:threadfon/features/thread_type_selection/widgets/thread_type_choice_card.dart';
import 'package:threadfon/localization/l10n_extension.dart';

class ThreadTypeSelectionScreen extends StatelessWidget {
  const ThreadTypeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final threadTypeRepository = ThreadTypeRepository();
    final localStorage = context.read<LocalStorage>();
    final languageBloc = context.read<LanguageBloc>();

    return BlocProvider(
      create: (_) => ThreadTypeBloc(
        repository: threadTypeRepository,
        localStorage: localStorage,
        languageBloc: languageBloc,
      )..load(),
      child: const _ThreadTypeSelectionView(),
    );
  }
}

class _ThreadTypeSelectionView extends StatelessWidget {
  const _ThreadTypeSelectionView();

  @override
  Widget build(BuildContext context) {
    final localization = context.l10n;

    return BlocListener<ThreadTypeBloc, ThreadTypeState>(
      listenWhen: (previous, current) => previous.enumNavigationStatus != current.enumNavigationStatus,
      listener: (context, state) {
        switch (state.enumNavigationStatus) {
          case EnumNavigationStatus.preparation:
          case EnumNavigationStatus.initial:
            break;

          case EnumNavigationStatus.navigation:
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (_) => const MetricDiameterScreen(),
              ),
            );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(localization.thread_type),
        ),
        body: Stack(
          children: [
            BlocBuilder<ThreadTypeBloc, ThreadTypeState>(
              builder: (context, state) {
                switch (state.enumPageStatus) {
                  case EnumPageStatus.initial:
                  case EnumPageStatus.loading:
                    return const MyLoadWidget();

                  case EnumPageStatus.error:
                    return MyErrorWidget(
                      errorMsg: state.errorMsg,
                      onRetry: () => context.read<ThreadTypeBloc>().load(),
                    );

                  case EnumPageStatus.success:
                    return ListView.builder(
                      shrinkWrap: false,
                      // padding: const EdgeInsets.all(8),

                      itemCount: state.threadTypes.length,
                      itemBuilder: (context, index) {
                        final threadType = state.threadTypes[index];
                        final label = threadType.enumThreadType == EnumThreadType.female
                            ? localization.internal_thread
                            : localization.external_thread;
                        return ThreadTypeChoiceCard(
                          svgAssetPath: threadType.svgAssetPath,
                          label: label,
                          onTap: () => context.read<ThreadTypeBloc>().preparationNavigation(threadType),
                        );
                      },
                    );
                }
              },
            ),
            BlocBuilder<ThreadTypeBloc, ThreadTypeState>(
              builder: (context, state) {
                if (state.enumNavigationStatus.isPreparation) {
                  return const BlurredOverlay();
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
