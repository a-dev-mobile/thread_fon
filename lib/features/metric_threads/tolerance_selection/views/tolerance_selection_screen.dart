import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:threadfon/app/language/language_bloc.dart';
import 'package:threadfon/core/constant/enum_navigation_status.dart';
import 'package:threadfon/core/constant/enum_status.dart';
import 'package:threadfon/core/services/api_service/api_service.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/core/widgets/loading_widget.dart';
import 'package:threadfon/core/widgets/my_error_widget.dart';
import 'package:threadfon/features/metric_threads/info/views/metric_info_screen.dart';
import 'package:threadfon/features/metric_threads/tolerance_selection/bloc/tolerance_bloc.dart';
import 'package:threadfon/features/metric_threads/tolerance_selection/models/tolerance_model.dart';
import 'package:threadfon/features/metric_threads/tolerance_selection/repositories/tolerance_repository.dart';
import 'package:threadfon/features/metric_threads/tolerance_selection/views/tolerance_choice_card.dart';
import 'package:threadfon/localization/generated/l10n.dart';
import 'package:threadfon/localization/l10n_extension.dart';

final LogService _logger = LogService('metric_tolerance_screen');

class ToleranceSelectionScreen extends StatefulWidget {
  const ToleranceSelectionScreen({super.key});
  static const String path = '/ToleranceSelectionScreen';
  static const String name = 'ToleranceSelectionScreen';

  @override
  State<ToleranceSelectionScreen> createState() =>
      _ToleranceSelectionScreenState();
}

class _ToleranceSelectionScreenState extends State<ToleranceSelectionScreen> {
  late ToleranceBloc _bloc;
  @override
  void initState() {
    super.initState();
    final ApiService apiService = context.read<ApiService>();
    final ToleranceRepository toleranceRepository =
        ToleranceRepository(apiService: apiService);
    final LocalStorage localStorage = context.read<LocalStorage>();
    final LanguageBloc languageBloc = context.read<LanguageBloc>();

    _bloc = ToleranceBloc(
      repository: toleranceRepository,
      localStorage: localStorage,
      languageBloc: languageBloc,
    )..loadTolerances();
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
    final GeneratedLocalization localization = context.l10n;

    return BlocListener<ToleranceBloc, ToleranceState>(
      listenWhen: (ToleranceState previous, ToleranceState current) =>
          previous.enumNavigationStatus != current.enumNavigationStatus,
      listener: (BuildContext context, ToleranceState state) {
        if (state.enumNavigationStatus.isNavigation) {
          context.pushNamed(MetricInfoScreen.name);
          bloc.resetNavigationStatus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(localization.select_tolerance),
        ),
        body: Stack(
          children: <Widget>[
            BlocBuilder<ToleranceBloc, ToleranceState>(
              builder: (BuildContext context, ToleranceState state) {
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
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(height: 8.0),
                      itemBuilder: (BuildContext context, int index) {
                        final ToleranceModel tolerance =
                            state.tolerances[index];
                        return ToleranceChoiceCard(
                          tolerance: tolerance,
                          onTap: () {
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
