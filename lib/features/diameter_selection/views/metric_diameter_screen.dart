import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threadfon/app/language/language_bloc.dart';
import 'package:threadfon/core/constant/enum_navigation.dart';
import 'package:threadfon/core/constant/enum_status.dart';
import 'package:threadfon/core/services/api_service/api_service.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/core/widgets/blurred_overlay.dart';
import 'package:threadfon/core/widgets/loading_widget.dart';
import 'package:threadfon/core/widgets/my_error_widget.dart';
import 'package:threadfon/features/diameter_selection/bloc/diameter_bloc.dart';
import 'package:threadfon/features/diameter_selection/repositories/diameter_repository.dart';
import 'package:threadfon/features/diameter_selection/views/widget/diameter_choice_card.dart';
import 'package:threadfon/features/pitch_selection/views/pitch_selection_screen.dart';
import 'package:threadfon/localization/l10n_extension.dart';

final _logger = LogService('metric_diameter_screen');

class MetricDiameterScreen extends StatefulWidget {
  const MetricDiameterScreen({super.key});

  @override
  State<MetricDiameterScreen> createState() => _MetricDiameterScreenState();
}

class _MetricDiameterScreenState extends State<MetricDiameterScreen> {
  @override
  Widget build(BuildContext context) {
    // Создаем экземпляр DiameterRepository здесь
    final apiService = context.read<ApiService>();
    final diameterRepository = DiameterRepository(apiService: apiService);
    final localStorage = context.read<LocalStorage>();
    final languageBloc = context.read<LanguageBloc>();

    return BlocProvider(
      create: (_) => DiameterBloc(
        repository: diameterRepository,
        localStorage: localStorage,
        languageBloc: languageBloc,
      )..load(),
      child: const _MetricDiameterView(),
    );
  }
}

class _MetricDiameterView extends StatefulWidget {
  const _MetricDiameterView();

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

  @override
  Widget build(BuildContext context) {
    final localization = context.l10n;

    return BlocListener<DiameterBloc, DiameterState>(
      listenWhen: (previous, current) => previous.enumNavigationStatus != current.enumNavigationStatus,
      listener: (context, state) async {
        if (state.enumNavigationStatus.isNavigation) {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (_) => const PitchSelectionScreen(),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(localization.select_diameter),
        ),
        body: Stack(
          children: [
            // Основной контент
            BlocBuilder<DiameterBloc, DiameterState>(
              buildWhen: (previous, current) => previous.enumPageStatus != current.enumPageStatus,
              builder: (context, state) {
                switch (state.enumPageStatus) {
                  case EnumStatus.initial:
                  case EnumStatus.loading:
                    return const LoadingWidget();

                  case EnumStatus.error:
                    return MyErrorWidget(
                      errorMsg: state.errorMsg,
                      onRetry: () => context.read<DiameterBloc>().load(),
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
                        return DiameterChoiceCard(
                          info: diameter.info,
                          onTap: () => context
                              .read<DiameterBloc>()
                              .preparationNavigation(diameter, _scrollController.position.pixels),
                        );
                      },
                    );
                }
              },
            ),
            BlocBuilder<DiameterBloc, DiameterState>(
              builder: (context, state) {
                if (state.enumNavigationStatus.isPreparation) {
                  return const LoadingWidget(isBlurred: true);
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
