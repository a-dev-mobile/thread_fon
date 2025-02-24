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
import 'package:threadfon/features/06_pipe_threads/diameter_selection/bloc/pipe_diameter_bloc.dart';
import 'package:threadfon/features/06_pipe_threads/diameter_selection/models/pipe_diameter_model.dart';
import 'package:threadfon/features/06_pipe_threads/diameter_selection/repositories/pipe_diameter_repository.dart';
import 'package:threadfon/features/06_pipe_threads/diameter_selection/views/pipe_diameter_choice_card.dart';
import 'package:threadfon/features/06_pipe_threads/info/views/pipe_info_screen.dart';

import 'package:threadfon/localization/generated/l10n.dart';
import 'package:threadfon/localization/l10n_extension.dart';

final LogService _logger = LogService('pipe_diameter_screen');

class PipeDiameterSelectionScreen extends StatefulWidget {
  const PipeDiameterSelectionScreen({super.key});
  static const String path = '/PipeDiameterSelectionScreen';
  static const String name = 'PipeDiameterSelectionScreen';

  @override
  State<PipeDiameterSelectionScreen> createState() =>
      _PipeDiameterSelectionScreenState();
}

class _PipeDiameterSelectionScreenState
    extends State<PipeDiameterSelectionScreen> {
  late final PipeDiameterBloc _bloc;

  @override
  void initState() {
    super.initState();
    final ApiService apiService = context.read<ApiService>();
    final PipeDiameterRepository diameterRepository =
        PipeDiameterRepository(apiService: apiService);
    final LocalStorage localStorage = context.read<LocalStorage>();
    final LanguageBloc languageBloc = context.read<LanguageBloc>();

    _bloc = PipeDiameterBloc(
      repository: diameterRepository,
      localStorage: localStorage,
      languageBloc: languageBloc,
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PipeDiameterBloc>.value(
      value: _bloc,
      child: const _DiameterSelectionView(),
    );
  }
}

class _DiameterSelectionView extends StatelessWidget {
  const _DiameterSelectionView();

  @override
  Widget build(BuildContext context) {
    final GeneratedLocalization localization = context.l10n;
    final PipeDiameterBloc bloc = context.read<PipeDiameterBloc>();

    return BlocListener<PipeDiameterBloc, PipeDiameterState>(
      listenWhen: (PipeDiameterState previous, PipeDiameterState current) =>
          previous.enumNavigationStatus != current.enumNavigationStatus,
      listener: (BuildContext context, PipeDiameterState state) {
        if (state.enumNavigationStatus.isNavigation) {
          context.pushNamed(PipeInfoScreen.name);
          bloc.resetNavigationStatus();
        }
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            BlocBuilder<PipeDiameterBloc, PipeDiameterState>(
              buildWhen:
                  (PipeDiameterState previous, PipeDiameterState current) =>
                      previous.enumPageStatus != current.enumPageStatus,
              builder: (BuildContext context, PipeDiameterState state) {
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
                      initialIndex: bloc.state.selectedThreadType ==
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
                              title: Text(localization.select_diameter),
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
                                _buildDiameterList(
                                    context, bloc.state.maleDiameters,
                                    isFemale: false),
                                _buildDiameterList(
                                    context, bloc.state.femaleDiameters,
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

  Widget _buildDiameterList(
      BuildContext context, List<PipeDiameterItem> diameters,
      {required bool isFemale}) {
    final PipeDiameterBloc bloc = context.read<PipeDiameterBloc>();

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: diameters.length,
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: 8.0),
      itemBuilder: (BuildContext context, int index) {
        final PipeDiameterItem diameter = diameters[index];

        return PipeDiameterChoiceCard(
          model: diameter,
          isFemale: isFemale,
          onTap: () {
            bloc.preparationNavigation(diameter);
          },
        );
      },
    );
  }
}
