// Package imports:

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:threadfon/app/language/language_bloc.dart';
import 'package:threadfon/core/constant/enum_navigation.dart';
import 'package:threadfon/core/constant/enum_status.dart';
import 'package:threadfon/core/constant/enum_thread.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';
import 'package:threadfon/core/widgets/base_screen.dart';
import 'package:threadfon/core/widgets/loading_widget.dart';
import 'package:threadfon/core/widgets/my_error_widget.dart';
import 'package:threadfon/features/thread_type_selection/bloc/thread_type_bloc.dart';
import 'package:threadfon/features/thread_type_selection/models/thread_type_model.dart';
import 'package:threadfon/features/thread_type_selection/repositories/thread_type_repository.dart';
import 'package:threadfon/features/thread_type_selection/views/widgets/thread_type_choice_card.dart';
import 'package:threadfon/localization/l10n_extension.dart';

class ThreadTypeSelectionScreen extends StatefulWidget {
  const ThreadTypeSelectionScreen({super.key});
  static const path = '/ThreadTypeSelectionScreen';
  static const name = 'ThreadTypeSelectionScreen';

  @override
  State<ThreadTypeSelectionScreen> createState() => _ThreadTypeSelectionScreenState();
}

class _ThreadTypeSelectionScreenState extends State<ThreadTypeSelectionScreen> {
  late ThreadTypeBloc _bloc;

  @override
  void initState() {
    super.initState();
    final threadTypeRepository = ThreadTypeRepository();
    final localStorage = context.read<LocalStorage>();
    final languageBloc = context.read<LanguageBloc>();

    _bloc = ThreadTypeBloc(
      repository: threadTypeRepository,
      localStorage: localStorage,
      languageBloc: languageBloc,
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _bloc,
      child: const _ThreadTypeSelectionView(),
    );
  }
}

class _ThreadTypeSelectionView extends StatelessWidget {
  const _ThreadTypeSelectionView();

  @override
  Widget build(BuildContext context) {
    final localization = context.l10n;
    final bloc = context.watch<ThreadTypeBloc>();
    return DrawerScreen(
        title: localization.thread_type,
        subtitle: bloc.state.coreUserSelection.enumThreads.isMetric
            ? '${localization.metric_thread_gost}\n${localization.metric_thread}'
            : '${localization.imperial_thread_gost}\n${localization.imperial_thread}',
        body: BlocListener<ThreadTypeBloc, ThreadTypeState>(
          listenWhen: (previous, current) => previous.enumNavigationStatus != current.enumNavigationStatus,
          listener: (context, state) {
            if (state.enumNavigationStatus.isNavigation) {
              context.pushNamed(state.nextNameScreen);
              bloc.resetNavigationStatus();
            }
          },
          child: Stack(
            children: [
              BlocBuilder<ThreadTypeBloc, ThreadTypeState>(
                builder: (context, state) {
                  switch (state.enumPageStatus) {
                    case EnumStatus.loading:
                      return const LoadingWidget();

                    case EnumStatus.error:
                      return MyErrorWidget(
                        errorMsg: state.errorMsg,
                        onRetry: () => context.read<ThreadTypeBloc>().load(),
                      );

                    case EnumStatus.success:
                      return Center(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min, // Центрирует по вертикали
                            children: state.threadTypes.map((threadType) {
                              final label = threadType.enumThreadType == EnumThreadMaleFemale.female
                                  ? localization.internal_thread
                                  : localization.external_thread;
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: FractionallySizedBox(
                                  widthFactor: 0.8, // Устанавливает ширину 80% от ширины родителя
                                  child: ThreadTypeChoiceCard(
                                    svgAssetPath: threadType.svgAssetPath,
                                    label: label,
                                    onTap: () {
                                      bloc.preparationNavigation(threadType);
                                    },
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                  }
                },
              ),
            ],
          ),
        ));
  }
}
