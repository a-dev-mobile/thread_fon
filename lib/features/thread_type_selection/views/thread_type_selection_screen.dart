// Package imports:

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threadfon/app/language/language_bloc.dart';
import 'package:threadfon/core/constant/enum_status.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';
import 'package:threadfon/core/widgets/my_error_widget.dart';
import 'package:threadfon/core/widgets/my_load_widget.dart';
import 'package:threadfon/features/diameter_selection/views/metric_diameter_screen.dart';
import 'package:threadfon/features/thread_type_selection/bloc/thread_type_bloc.dart';
import 'package:threadfon/features/thread_type_selection/models/thread_type_model.dart';
import 'package:threadfon/features/thread_type_selection/repositories/thread_type_repository.dart';
import 'package:threadfon/features/thread_type_selection/widgets/thread_type_choice_card.dart';
import 'package:threadfon/localization/l10n.dart';

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
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == EnumStatus.navigating) {
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
        body: BlocBuilder<ThreadTypeBloc, ThreadTypeState>(
          builder: (context, state) {
            switch (state.status) {
              case EnumStatus.initial:
              case EnumStatus.loading:
              case EnumStatus.preparingNavigation:
              case EnumStatus.navigating:
                return const MyLoadWidget();

              case EnumStatus.error:
                return MyErrorWidget(
                  errorMsg: state.errorMsg,
                  onRetry: () => context.read<ThreadTypeBloc>().load(),
                );

              case EnumStatus.success:
                return ListView.builder(
                  shrinkWrap: false,
                  // padding: const EdgeInsets.all(8),
                
                  itemCount: state.threadTypes.length,
                  itemBuilder: (context, index) {
                    final threadType = state.threadTypes[index];
                    final label = threadType.enumThreadType == EnumThreadType.f
                        ? localization.internal_thread
                        : localization.external_thread;
                    return Expanded(
                      child: ThreadTypeChoiceCard(
                        svgAssetPath: threadType.svgAssetPath,
                        label: label,
                        onTap: () => context
                            .read<ThreadTypeBloc>()
                            .selectThreadType(threadType),
                      ),
                    );
                  },
                );
            }
          },
        ),
      ),
    );
  }
}
