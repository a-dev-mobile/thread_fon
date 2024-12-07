import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:threadfon/app/language/language_bloc.dart';
import 'package:threadfon/core/constant/enum_navigation.dart';
import 'package:threadfon/core/constant/enum_status.dart';
import 'package:threadfon/core/services/api_service/api_service.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/core/widgets/loading_widget.dart';
import 'package:threadfon/core/widgets/my_error_widget.dart';
import 'package:threadfon/features/imperial_threads/diameter_selection/bloc/imperial_diameter_bloc.dart';
import 'package:threadfon/features/imperial_threads/diameter_selection/repositories/imperial_diameter_repository.dart';
import 'package:threadfon/features/imperial_threads/diameter_selection/views/widget/imperial_diameter_choice_card.dart';
import 'package:threadfon/features/imperial_threads/tolerance_selection/views/imperial_tolerance_selection_screen.dart';
import 'package:threadfon/localization/l10n_extension.dart';

final _logger = LogService('imperial_diameter_screen');

class ImperialDiameterScreen extends StatefulWidget {
  static const path = '/ImperialDiameterScreen';
  static const name = 'ImperialDiameterScreen';
  const ImperialDiameterScreen({super.key});

  @override
  State<ImperialDiameterScreen> createState() => _ImperialDiameterScreenState();
}

class _ImperialDiameterScreenState extends State<ImperialDiameterScreen> {
  late ImperialDiameterBloc _bloc;

  @override
  void initState() {
    super.initState();
    final apiService = context.read<ApiService>();
    final diameterRepository = DiameterRepository(apiService: apiService);
    final localStorage = context.read<LocalStorage>();
    final languageBloc = context.read<LanguageBloc>();

    _bloc = ImperialDiameterBloc(
      repository: diameterRepository,
      localStorage: localStorage,
      languageBloc: languageBloc,
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ImperialDiameterBloc>.value(
      value: _bloc,
      child: _ImperialDiameterView(_bloc),
    );
  }
}

class _ImperialDiameterView extends StatefulWidget {
  const _ImperialDiameterView(this.bloc);
  final ImperialDiameterBloc bloc;

  @override
  State<_ImperialDiameterView> createState() => _ImperialDiameterViewState();
}

class _ImperialDiameterViewState extends State<_ImperialDiameterView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = context.l10n;
    final bloc = widget.bloc;
    return BlocListener<ImperialDiameterBloc, ImperialDiameterState>(
      listenWhen: (previous, current) => previous.enumNavigationStatus != current.enumNavigationStatus,
      listener: (context, state) async {
        if (state.enumNavigationStatus.isNavigation) {
          // Навигация на следующий экран при выборе
          context.pushNamed(ImperialToleranceSelectionScreen.name);

          // Сброс статуса навигации через публичный метод
          bloc.resetNavigationStatus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(localization.select_diameter),
        ),
        body: Stack(
          children: [
            BlocBuilder<ImperialDiameterBloc, ImperialDiameterState>(
              buildWhen: (previous, current) =>
                  previous.enumPageStatus != current.enumPageStatus || previous.diameters != current.diameters,
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
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (_scrollController.hasClients) {
                        _scrollController.jumpTo(state.scrollPosition);
                      }
                    });
                    return ListView.separated(
                      controller: _scrollController,
                      itemCount: state.diameters.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 8.0),
                      itemBuilder: (context, index) {
                        final diameter = state.diameters[index];
                        return ImperialDiameterChoiceCard(
                          formatted: diameter.formatted,
                          series: diameter.series,
                          tpi: diameter.tpi,
                          diameter: diameter.diameter,
                          onTap: () => bloc.preparationNavigation(
                            diameter,
                            _scrollController.position.pixels,
                          ),
                        );
                      },
                    );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
