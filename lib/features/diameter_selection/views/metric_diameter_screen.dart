import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threadfon/app/language/language_bloc.dart';
import 'package:threadfon/core/constant/enum_navigation.dart';
import 'package:threadfon/core/constant/enum_status.dart';
import 'package:threadfon/core/services/api_service/api_service.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/core/widgets/blurred_overlay.dart';
import 'package:threadfon/core/widgets/my_error_widget.dart';
import 'package:threadfon/core/widgets/my_load_widget.dart';
import 'package:threadfon/features/diameter_selection/bloc/diameter_bloc.dart';
import 'package:threadfon/features/diameter_selection/repositories/diameter_repository.dart';
import 'package:threadfon/features/diameter_selection/views/widget/diameter_choice_card.dart';
import 'package:threadfon/features/pitch_selection/views/pitch_selection_screen.dart';
import 'package:threadfon/localization/l10n.dart';

final _logger = LogService('metric_diameter_screen');

class MetricDiameterScreen extends StatelessWidget {
  const MetricDiameterScreen({super.key});

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
      )..loadDiameters(),
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
  @override
  Widget build(BuildContext context) {
    final localization = context.l10n;

    return BlocListener<DiameterBloc, DiameterState>(
      listenWhen: (previous, current) => previous.enumNavigationStatus != current.enumNavigationStatus,
      listener: (context, state) async {
        switch (state.enumNavigationStatus) {
          case EnumNavigationStatus.preparation:
          // await saveScrollPosition();
          case EnumNavigationStatus.initial:
            break;
          case EnumNavigationStatus.navigation:
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
              builder: (context, state) {
                switch (state.enumPageStatus) {
                  case EnumPageStatus.initial:
                  case EnumPageStatus.loading:
                    return const MyLoadWidget();

                  case EnumPageStatus.error:
                    return MyErrorWidget(
                      errorMsg: state.errorMsg,
                      onRetry: () => context.read<DiameterBloc>().loadDiameters(),
                    );
                  case EnumPageStatus.success:
                    return ListView.separated(
                      itemCount: state.diameters.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 8.0),
                      itemBuilder: (context, index) {
                        final diameter = state.diameters[index];
                        return DiameterChoiceCard(
                          info: diameter.info,
                          onTap: () => context.read<DiameterBloc>().preparationNavigation(diameter),
                        );
                      },
                    );
                }
              },
            ),
            // Блюр-оверлей
            BlocBuilder<DiameterBloc, DiameterState>(
              builder: (context, state) {
                if (state.enumNavigationStatus.isPreparation) {
                  return const BlurredOverlay();
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
