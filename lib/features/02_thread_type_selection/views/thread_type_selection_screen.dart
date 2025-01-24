// Package imports:

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:threadfon/app/language/language_bloc.dart';
import 'package:threadfon/core/constant/enum_navigation_status.dart';
import 'package:threadfon/core/constant/enum_status.dart';
import 'package:threadfon/core/constant/enum_thread_male_female.dart';
import 'package:threadfon/core/constant/enum_threads.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';
import 'package:threadfon/core/widgets/drawer_screen.dart';
import 'package:threadfon/core/widgets/loading_widget.dart';
import 'package:threadfon/core/widgets/my_error_widget.dart';
import 'package:threadfon/features/02_thread_type_selection/bloc/thread_type_bloc.dart';
import 'package:threadfon/features/02_thread_type_selection/models/thread_type_model.dart';
import 'package:threadfon/features/02_thread_type_selection/repositories/thread_type_repository.dart';
import 'package:threadfon/features/02_thread_type_selection/views/widgets/thread_type_choice_card.dart';
import 'package:threadfon/localization/generated/l10n.dart';
import 'package:threadfon/localization/l10n_extension.dart';

class ThreadTypeSelectionScreen extends StatefulWidget {
  const ThreadTypeSelectionScreen({super.key});
  static const String path = '/ThreadTypeSelectionScreen';
  static const String name = 'ThreadTypeSelectionScreen';

  @override
  State<ThreadTypeSelectionScreen> createState() =>
      _ThreadTypeSelectionScreenState();
}

class _ThreadTypeSelectionScreenState extends State<ThreadTypeSelectionScreen> {
  late ThreadTypeBloc _bloc;

  @override
  void initState() {
    super.initState();
    final ThreadTypeRepository threadTypeRepository = ThreadTypeRepository();
    final LocalStorage localStorage = context.read<LocalStorage>();
    final LanguageBloc languageBloc = context.read<LanguageBloc>();

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
    final GeneratedLocalization localization = context.l10n;
    final ThreadTypeBloc bloc = context.watch<ThreadTypeBloc>();

    return DrawerScreen(
        title: localization.thread_type,
        subtitle: switch (bloc.state.coreUserSelection.enumThreads) {
          EnumThreads.metric =>
            '${localization.metric_thread_gost}\n${localization.metric_thread}',
          EnumThreads.imperial =>
            '${localization.imperial_thread_gost}\n${localization.imperial_thread}',
          EnumThreads.trapezoidal => '${localization.trapezoidal_thread_gost}\n${localization.trapezoidal_thread}',

        },
        body: BlocListener<ThreadTypeBloc, ThreadTypeState>(
          listenWhen: (ThreadTypeState previous, ThreadTypeState current) =>
              previous.enumNavigationStatus != current.enumNavigationStatus,
          listener: (BuildContext context, ThreadTypeState state) {
            if (state.enumNavigationStatus.isNavigation) {
              context.pushNamed(state.nextNameScreen);
              bloc.resetNavigationStatus();
            }
          },
          child: Stack(
            children: <Widget>[
              BlocBuilder<ThreadTypeBloc, ThreadTypeState>(
                builder: (BuildContext context, ThreadTypeState state) {
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
                            mainAxisSize:
                                MainAxisSize.min, // Центрирует по вертикали
                            children: state.threadTypes
                                .map((ThreadTypeModel threadType) {
                              final String label = threadType.enumThreadType ==
                                      EnumThreadMaleFemale.female
                                  ? localization.internal_thread
                                  : localization.external_thread;
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: FractionallySizedBox(
                                  widthFactor:
                                      0.8, // Устанавливает ширину 80% от ширины родителя
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
