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
import 'package:threadfon/features/metric_threads/info/views/info_screen.dart';
import 'package:threadfon/features/metric_threads/tolerance_selection/bloc/tolerance_bloc.dart';
import 'package:threadfon/features/metric_threads/tolerance_selection/repositories/tolerance_repository.dart';
import 'package:threadfon/features/metric_threads/tolerance_selection/views/tolerance_choice_card.dart';
import 'package:threadfon/localization/l10n_extension.dart';
import 'package:threadfon/main.dart';

final _logger = LogService('metric_tolerance_screen');

class ToleranceSelectionScreen extends StatefulWidget {
  const ToleranceSelectionScreen({super.key});
  static const path = '/ToleranceSelectionScreen';
  static const name = 'ToleranceSelectionScreen';

  @override
  State<ToleranceSelectionScreen> createState() =>
      _ToleranceSelectionScreenState();
}

class _ToleranceSelectionScreenState extends State<ToleranceSelectionScreen> {
  late ToleranceBloc _bloc;
  @override
  void initState() {
    super.initState();
    final apiService = context.read<ApiService>();
    final toleranceRepository = ToleranceRepository(apiService: apiService);
    final localStorage = context.read<LocalStorage>();
    final languageBloc = context.read<LanguageBloc>();

    _bloc = ToleranceBloc(
      repository: toleranceRepository,
      localStorage: localStorage,
      languageBloc: languageBloc,
    )..loadTolerances();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _bloc,
      child: _ToleranceSelectionView(_bloc),
    );
  }
}

class _ToleranceSelectionView extends StatelessWidget {
  const _ToleranceSelectionView(this.bloc);
  final ToleranceBloc bloc;
  @override
  Widget build(BuildContext context) {
    final localization = context.l10n;

    return BlocListener<ToleranceBloc, ToleranceState>(
      listenWhen: (previous, current) =>
          previous.enumNavigationStatus != current.enumNavigationStatus,
      listener: (context, state) {
        if (state.enumNavigationStatus.isNavigation) {
          analytics.logEvent(name: 'info_screen_view');
          context.pushNamed(InfoScreen.name);
          bloc.resetNavigationStatus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(localization.select_tolerance),
        ),
        body: Stack(
          children: [
            BlocBuilder<ToleranceBloc, ToleranceState>(
              builder: (context, state) {
                switch (state.enumPageStatus) {
                  case EnumStatus.loading:
                    return const LoadingWidget();

                  case EnumStatus.error:
                    return MyErrorWidget(
                      errorMsg: state.errorMsg,
                      onRetry: () => bloc.loadTolerances(),
                    );

                  case EnumStatus.success:
                    return ListView.separated(
                      itemCount: state.tolerances.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 8.0),
                      itemBuilder: (context, index) {
                        final tolerance = state.tolerances[index];
                        return ToleranceChoiceCard(
                          tolerance: tolerance,
                          onTap: () {
                            // Логируем выбор допуска
                            analytics.logEvent(
                              name: 'tolerance_selected',
                              parameters: {
                                'tolerance_value': tolerance
                                    .info, // Предполагается, что tolerance имеет поле value
                              },
                            );
                            bloc.preparationNavigation(tolerance);
                          },
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
