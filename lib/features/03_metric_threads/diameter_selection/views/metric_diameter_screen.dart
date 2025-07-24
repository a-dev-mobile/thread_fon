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
import 'package:threadfon/features/03_metric_threads/diameter_selection/bloc/metric_diameter_bloc.dart';
import 'package:threadfon/features/03_metric_threads/diameter_selection/models/metric_diameter_model.dart';
import 'package:threadfon/features/03_metric_threads/diameter_selection/repositories/metric_diameter_repository.dart';
import 'package:threadfon/features/03_metric_threads/diameter_selection/views/widget/diameter_choice_card.dart';
import 'package:threadfon/features/03_metric_threads/pitch_selection/views/pitch_selection_screen.dart';
import 'package:threadfon/localization/generated/l10n.dart';
import 'package:threadfon/localization/l10n_extension.dart';

final LogService _logger = LogService('metric_diameter_screen');

class MetricDiameterScreen extends StatefulWidget {
  static const String path = '/MetricDiameterScreen';
  static const String name = 'MetricDiameterScreen';
  const MetricDiameterScreen({super.key});

  @override
  State<MetricDiameterScreen> createState() => _MetricDiameterScreenState();
}

class _MetricDiameterScreenState extends State<MetricDiameterScreen> {
  late MetricDiameterBloc _bloc;

  @override
  void initState() {
    super.initState();
    final ApiService apiService = context.read<ApiService>();
    final DiameterRepository diameterRepository = DiameterRepository(
      apiService: apiService,
    );
    final LocalStorage localStorage = context.read<LocalStorage>();
    final LanguageBloc languageBloc = context.read<LanguageBloc>();

    _bloc = MetricDiameterBloc(
      repository: diameterRepository,
      localStorage: localStorage,
      languageBloc: languageBloc,
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MetricDiameterBloc>.value(
      value: _bloc,
      child: _MetricDiameterView(_bloc),
    );
  }
}

class _MetricDiameterView extends StatefulWidget {
  const _MetricDiameterView(this.bloc);
  final MetricDiameterBloc bloc;
  @override
  State<_MetricDiameterView> createState() => _MetricDiameterViewState();
}

class _MetricDiameterViewState extends State<_MetricDiameterView> {
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

  void _updateScrollPosition(double position) {
    if (!mounted) return;
    if (_scrollController.hasClients && position > 0) {
      try {
        _scrollController.jumpTo(position);
      } catch (e) {
        _logger.e('Error updating scroll position: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final GeneratedLocalization localization = context.l10n;
    final MetricDiameterBloc bloc = widget.bloc;
    return BlocListener<MetricDiameterBloc, MetricDiameterState>(
      listenWhen: (MetricDiameterState previous, MetricDiameterState current) =>
          previous.enumNavigationStatus != current.enumNavigationStatus,
      listener: (BuildContext context, MetricDiameterState state) async {
        if (state.enumNavigationStatus.isNavigation) {
          context.pushNamed(PitchSelectionScreen.name);

          // Сброс статуса навигации через публичный метод
          bloc.resetNavigationStatus();
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text(localization.select_diameter)),
        body: Stack(
          children: <Widget>[
            // Основной контент
            BlocBuilder<MetricDiameterBloc, MetricDiameterState>(
              buildWhen:
                  (MetricDiameterState previous, MetricDiameterState current) =>
                      previous.enumPageStatus != current.enumPageStatus,
              builder: (BuildContext context, MetricDiameterState state) {
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
                      _updateScrollPosition(state.scrollPosition);
                    });
                    return ListView.separated(
                      controller: _scrollController,
                      itemCount: state.diameters.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(height: 8.0),
                      itemBuilder: (BuildContext context, int index) {
                        final MetricDiameterModel diameter =
                            state.diameters[index];
                        return DiameterChoiceCard(
                          info: diameter.info,
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
