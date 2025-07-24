import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:threadfon/app/language/language_bloc.dart';
import 'package:threadfon/core/constant/enum_navigation_status.dart';
import 'package:threadfon/core/constant/enum_status.dart';
import 'package:threadfon/core/constant/enum_thread_male_female.dart';
import 'package:threadfon/core/services/api_service/api_service.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/core/widgets/loading_widget.dart';
import 'package:threadfon/core/widgets/my_error_widget.dart';
import 'package:threadfon/features/05_trapezoidal_threads/info/views/trapezoidal_info_screen.dart';

import 'package:threadfon/features/05_trapezoidal_threads/tolerance_selection/bloc/trapezoidal_tolerance_bloc.dart';
import 'package:threadfon/features/05_trapezoidal_threads/tolerance_selection/models/trapezoidal_tolerance_model.dart';
import 'package:threadfon/features/05_trapezoidal_threads/tolerance_selection/repositories/trapezoidal_tolerance_repository.dart';
import 'package:threadfon/features/05_trapezoidal_threads/tolerance_selection/views/trapezoidal_tolerance_choice_card.dart';
import 'package:threadfon/localization/generated/l10n.dart';
import 'package:threadfon/localization/l10n_extension.dart';

final LogService _logger = LogService('trapezoidal_tolerance_screen');

class TrapezoidalToleranceSelectionScreen extends StatefulWidget {
  const TrapezoidalToleranceSelectionScreen({super.key});
  static const String path = '/TrapezoidalToleranceSelectionScreen';
  static const String name = 'TrapezoidalToleranceSelectionScreen';

  @override
  State<TrapezoidalToleranceSelectionScreen> createState() =>
      _TrapezoidalToleranceSelectionScreenState();
}

class _TrapezoidalToleranceSelectionScreenState
    extends State<TrapezoidalToleranceSelectionScreen> {
  late final TrapezoidalToleranceBloc _bloc;

  @override
  void initState() {
    super.initState();
    final ApiService apiService = context.read<ApiService>();
    final TrapezoidalToleranceRepository toleranceRepository =
        TrapezoidalToleranceRepository(apiService: apiService);
    final LocalStorage localStorage = context.read<LocalStorage>();
    final LanguageBloc languageBloc = context.read<LanguageBloc>();

    _bloc = TrapezoidalToleranceBloc(
      repository: toleranceRepository,
      localStorage: localStorage,
      languageBloc: languageBloc,
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TrapezoidalToleranceBloc>.value(
      value: _bloc,
      child: const _ToleranceSelectionView(),
    );
  }
}

class _ToleranceSelectionView extends StatelessWidget {
  const _ToleranceSelectionView();

  @override
  Widget build(BuildContext context) {
    final GeneratedLocalization localization = context.l10n;
    final TrapezoidalToleranceBloc bloc = context
        .read<TrapezoidalToleranceBloc>();

    return BlocListener<TrapezoidalToleranceBloc, TrapezoidalToleranceState>(
      listenWhen:
          (
            TrapezoidalToleranceState previous,
            TrapezoidalToleranceState current,
          ) => previous.enumNavigationStatus != current.enumNavigationStatus,
      listener: (BuildContext context, TrapezoidalToleranceState state) {
        if (state.enumNavigationStatus.isNavigation) {
          context.pushNamed(TrapezoidalInfoScreen.name);
          bloc.resetNavigationStatus();
        }
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            BlocBuilder<TrapezoidalToleranceBloc, TrapezoidalToleranceState>(
              buildWhen:
                  (
                    TrapezoidalToleranceState previous,
                    TrapezoidalToleranceState current,
                  ) => previous.enumPageStatus != current.enumPageStatus,
              builder: (BuildContext context, TrapezoidalToleranceState state) {
                switch (state.enumPageStatus) {
                  case EnumStatus.loading:
                    return const LoadingWidget();
                  case EnumStatus.error:
                    return MyErrorWidget(
                      errorMsg: state.errorMsg,
                      onRetry: () => bloc.load(),
                    );
                  case EnumStatus.success:
                    return DefaultTabController(
                      length: 2,
                      initialIndex:
                          bloc.state.selectedThreadType ==
                              EnumThreadMaleFemale.female
                          ? 1
                          : 0,
                      child: Builder(
                        builder: (BuildContext context) {
                          final TabController tabController =
                              DefaultTabController.of(context);
                          tabController.addListener(() {
                            if (!tabController.indexIsChanging) {
                              final EnumThreadMaleFemale newGender =
                                  tabController.index == 1
                                  ? EnumThreadMaleFemale.female
                                  : EnumThreadMaleFemale.male;
                              if (bloc.state.selectedThreadType != newGender) {
                                bloc.updateGenderSelection(newGender);
                              }
                            }
                          });

                          return Scaffold(
                            appBar: AppBar(
                              title: Text(localization.select_class),
                              bottom: TabBar(
                                onTap: (int index) {
                                  final EnumThreadMaleFemale newGender =
                                      index == 1
                                      ? EnumThreadMaleFemale.female
                                      : EnumThreadMaleFemale.male;
                                  if (bloc.state.selectedThreadType !=
                                      newGender) {
                                    bloc.updateGenderSelection(newGender);
                                  }
                                },
                                tabs: <Widget>[
                                  Tab(text: localization.external_thread),
                                  Tab(text: localization.internal_thread),
                                ],
                              ),
                            ),
                            body: TabBarView(
                              children: <Widget>[
                                _buildToleranceList(
                                  context,
                                  bloc.state.maleTolerances,
                                  isFemale: false,
                                ),
                                _buildToleranceList(
                                  context,
                                  bloc.state.femaleTolerances,
                                  isFemale: true,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToleranceList(
    BuildContext context,
    List<TrapezoidalToleranceItem> tolerances, {
    required bool isFemale,
  }) {
    final TrapezoidalToleranceBloc bloc = context
        .read<TrapezoidalToleranceBloc>();

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: tolerances.length,
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: 8.0),
      itemBuilder: (BuildContext context, int index) {
        final TrapezoidalToleranceItem tolerance = tolerances[index];

        return TrapezoidalToleranceChoiceCard(
          tolerance: tolerance,
          onTap: () {
            bloc.preparationNavigation(tolerance, isFemale);
          },
        );
      },
    );
  }
}
