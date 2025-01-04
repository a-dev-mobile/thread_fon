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
import 'package:threadfon/features/imperial_threads/info/views/imperial_info_screen.dart';
import 'package:threadfon/features/imperial_threads/tolerance_selection/bloc/imperial_tolerance_bloc.dart';
import 'package:threadfon/features/imperial_threads/tolerance_selection/models/imperial_tolerance_model.dart';
import 'package:threadfon/features/imperial_threads/tolerance_selection/repositories/imperial_tolerance_repository.dart';
import 'package:threadfon/features/imperial_threads/tolerance_selection/views/imperial_tolerance_choice_card.dart';
import 'package:threadfon/localization/l10n_extension.dart';

final _logger = LogService('imperial_tolerance_screen');

class ImperialToleranceSelectionScreen extends StatefulWidget {
  const ImperialToleranceSelectionScreen({super.key});
  static const path = '/ImperialToleranceSelectionScreen';
  static const name = 'ImperialToleranceSelectionScreen';

  @override
  State<ImperialToleranceSelectionScreen> createState() => _ImperialToleranceSelectionScreenState();
}

class _ImperialToleranceSelectionScreenState extends State<ImperialToleranceSelectionScreen> {
  late final ImperialToleranceBloc _bloc;

  @override
  void initState() {
    super.initState();
    final apiService = context.read<ApiService>();
    final toleranceRepository = Imperial(apiService: apiService);
    final localStorage = context.read<LocalStorage>();
    final languageBloc = context.read<LanguageBloc>();

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
    final localization = context.l10n;
    final bloc = context.read<ImperialToleranceBloc>();

    return BlocListener<ImperialToleranceBloc, ImperialToleranceState>(
      listenWhen: (previous, current) => previous.enumNavigationStatus != current.enumNavigationStatus,
      listener: (context, state) {
        if (state.enumNavigationStatus.isNavigation) {
          // Навигация на следующий экран при выборе допуска
          context.pushNamed(ImperialInfoScreen.name);

          // Сброс статуса навигации
          bloc.resetNavigationStatus();
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            BlocBuilder<ImperialToleranceBloc, ImperialToleranceState>(
              buildWhen: (previous, current) => previous.enumPageStatus != current.enumPageStatus,
              builder: (context, state) {
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
                      child: Scaffold(
                        appBar: AppBar(
                          title: Text(localization.select_class),
                          bottom: TabBar(
                            onTap: (index) {
                              final newGender = index == 1 ? EnumThreadMaleFemale.female : EnumThreadMaleFemale.male;
                              if (bloc.state.selectedThreadType != newGender) {
                                bloc.updateGenderSelection(newGender);
                              }
                            },
                            tabs: [
                              Tab(text: localization.external_thread),
                              Tab(text: localization.internal_thread),
                            ],
                          ),
                        ),
                        body: TabBarView(
                          children: [
                            _buildToleranceList(context, bloc.state.maleTolerances, isFemale: false),
                            _buildToleranceList(context, bloc.state.femaleTolerances, isFemale: true),
                          ],
                        ),
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

  Widget _buildToleranceList(BuildContext context, List<ImperialToleranceItem> tolerances, {required bool isFemale}) {
    final bloc = context.read<ImperialToleranceBloc>();
    final localization = context.l10n;

    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: tolerances.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8.0),
      itemBuilder: (context, index) {
        final tolerance = tolerances[index];
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
