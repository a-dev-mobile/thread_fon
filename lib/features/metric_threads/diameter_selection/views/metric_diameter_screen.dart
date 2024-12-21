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
import 'package:threadfon/features/metric_threads/diameter_selection/bloc/metric_diameter_bloc.dart';
import 'package:threadfon/features/metric_threads/diameter_selection/repositories/metric_diameter_repository.dart';
import 'package:threadfon/features/metric_threads/diameter_selection/views/widget/diameter_choice_card.dart';
import 'package:threadfon/features/metric_threads/pitch_selection/views/pitch_selection_screen.dart';
import 'package:threadfon/localization/l10n_extension.dart';

final _logger = LogService('metric_diameter_screen');

class MetricDiameterScreen extends StatefulWidget {
  static const path = '/MetricDiameterScreen';
  static const name = 'MetricDiameterScreen';
  const MetricDiameterScreen({super.key});

  @override
  State<MetricDiameterScreen> createState() => _MetricDiameterScreenState();
}

class _MetricDiameterScreenState extends State<MetricDiameterScreen> {
  late MetricDiameterBloc _bloc;

  @override
  void initState() {
    super.initState();
    final apiService = context.read<ApiService>();
    final diameterRepository = DiameterRepository(apiService: apiService);
    final localStorage = context.read<LocalStorage>();
    final languageBloc = context.read<LanguageBloc>();

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
    final localization = context.l10n;
    final bloc = widget.bloc;
    return BlocListener<MetricDiameterBloc, MetricDiameterState>(
      listenWhen: (previous, current) =>
          previous.enumNavigationStatus != current.enumNavigationStatus,
      listener: (context, state) async {
        if (state.enumNavigationStatus.isNavigation) {
          context.pushNamed(PitchSelectionScreen.name);

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
            // Основной контент
            BlocBuilder<MetricDiameterBloc, MetricDiameterState>(
              buildWhen: (previous, current) =>
                  previous.enumPageStatus != current.enumPageStatus,
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
                      _updateScrollPosition(state.scrollPosition);
                    });
                    return ListView.separated(
                      controller: _scrollController,
                      itemCount: state.diameters.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 8.0),
                      itemBuilder: (context, index) {
                        final diameter = state.diameters[index];
                        return DiameterChoiceCard(
                          info: diameter.info,
                          onTap: () => bloc.preparationNavigation(
                              diameter, _scrollController.position.pixels),
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
