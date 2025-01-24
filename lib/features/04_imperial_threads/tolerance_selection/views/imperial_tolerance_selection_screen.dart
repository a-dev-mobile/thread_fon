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
import 'package:threadfon/features/04_imperial_threads/info/views/imperial_info_screen.dart';
import 'package:threadfon/features/04_imperial_threads/tolerance_selection/bloc/imperial_tolerance_bloc.dart';
import 'package:threadfon/features/04_imperial_threads/tolerance_selection/models/imperial_tolerance_model.dart';
import 'package:threadfon/features/04_imperial_threads/tolerance_selection/repositories/imperial_tolerance_repository.dart';
import 'package:threadfon/features/04_imperial_threads/tolerance_selection/views/imperial_tolerance_choice_card.dart';
import 'package:threadfon/localization/generated/l10n.dart';
import 'package:threadfon/localization/l10n_extension.dart';

final LogService _logger = LogService('imperial_tolerance_screen');

class ImperialToleranceSelectionScreen extends StatefulWidget {
  const ImperialToleranceSelectionScreen({super.key});
  static const String path = '/ImperialToleranceSelectionScreen';
  static const String name = 'ImperialToleranceSelectionScreen';

  @override
  State<ImperialToleranceSelectionScreen> createState() =>
      _ImperialToleranceSelectionScreenState();
}

class _ImperialToleranceSelectionScreenState
    extends State<ImperialToleranceSelectionScreen> {
  late final ImperialToleranceBloc _bloc;

  @override
  void initState() {
    super.initState();
    final ApiService apiService = context.read<ApiService>();
    final Imperial toleranceRepository = Imperial(apiService: apiService);
    final LocalStorage localStorage = context.read<LocalStorage>();
    final LanguageBloc languageBloc = context.read<LanguageBloc>();

    _bloc = ImperialToleranceBloc(
      repository: toleranceRepository,
      localStorage: localStorage,
      languageBloc: languageBloc,
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ImperialToleranceBloc>.value(
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
    final ImperialToleranceBloc bloc = context.read<ImperialToleranceBloc>();

    return BlocListener<ImperialToleranceBloc, ImperialToleranceState>(
      listenWhen:
          (ImperialToleranceState previous, ImperialToleranceState current) =>
              previous.enumNavigationStatus != current.enumNavigationStatus,
      listener: (BuildContext context, ImperialToleranceState state) {
        if (state.enumNavigationStatus.isNavigation) {
          // Навигация на следующий экран при выборе допуска
          context.pushNamed(ImperialInfoScreen.name);

          // Сброс статуса навигации
          bloc.resetNavigationStatus();
        }
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            BlocBuilder<ImperialToleranceBloc, ImperialToleranceState>(
              buildWhen: (ImperialToleranceState previous,
                      ImperialToleranceState current) =>
                  previous.enumPageStatus != current.enumPageStatus,
              builder: (BuildContext context, ImperialToleranceState state) {
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
                      initialIndex: bloc.state.selectedThreadType == EnumThreadMaleFemale.female ? 1 : 0,
                      child: Builder(
                        builder: (BuildContext context) {
                          final TabController tabController = DefaultTabController.of(context);
                          tabController.addListener(() {
                            if (!tabController.indexIsChanging) {
                              final EnumThreadMaleFemale newGender = tabController.index == 1
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
                                  final EnumThreadMaleFemale newGender = index == 1
                                      ? EnumThreadMaleFemale.female
                                      : EnumThreadMaleFemale.male;
                                  if (bloc.state.selectedThreadType != newGender) {
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
                                    context, bloc.state.maleTolerances,
                                    isFemale: false),
                                _buildToleranceList(
                                    context, bloc.state.femaleTolerances,
                                    isFemale: true),
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
      BuildContext context, List<ImperialToleranceItem> tolerances,
      {required bool isFemale}) {
    final ImperialToleranceBloc bloc = context.read<ImperialToleranceBloc>();
    final GeneratedLocalization localization = context.l10n;

    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: tolerances.length,
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: 8.0),
      itemBuilder: (BuildContext context, int index) {
        final ImperialToleranceItem tolerance = tolerances[index];
        return ImperialToleranceChoiceCard(
          tolerance: tolerance,
          onTap: () {
            bloc.preparationNavigation(tolerance, isFemale);
          },
        );
      },
    );
  }
}
