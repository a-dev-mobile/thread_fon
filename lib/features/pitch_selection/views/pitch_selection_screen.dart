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
import 'package:threadfon/features/pitch_selection/bloc/pitch_bloc.dart';
import 'package:threadfon/features/pitch_selection/models/pitch_model.dart';
import 'package:threadfon/features/pitch_selection/repositories/pitch_repository.dart';
import 'package:threadfon/features/pitch_selection/views/pitch_choice_card.dart';
import 'package:threadfon/features/tolerance_selection/views/tolerance_selection_screen.dart';
import 'package:threadfon/localization/l10n_extension.dart';

final _logger = LogService('metric_pitch_screen');

class PitchSelectionScreen extends StatelessWidget {
  const PitchSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final apiService = context.read<ApiService>();
    final pitchRepository = PitchRepository(apiService: apiService);
    final localStorage = context.read<LocalStorage>();
    final languageBloc = context.read<LanguageBloc>();

    return BlocProvider(
      create: (_) => PitchBloc(
        repository: pitchRepository,
        localStorage: localStorage,
        languageBloc: languageBloc,
      )..loadPitch(),
      child: const _PitchSelectionView(),
    );
  }
}

class _PitchSelectionView extends StatelessWidget {
  const _PitchSelectionView();

  @override
  Widget build(BuildContext context) {
    final localization = context.l10n;

    return BlocListener<PitchBloc, PitchState>(
      listenWhen: (previous, current) => previous.enumNavigationStatus != current.enumNavigationStatus,
      listener: (context, state) {
        switch (state.enumNavigationStatus) {
          case EnumNavigationStatus.preparation:
          case EnumNavigationStatus.initial:
            // await saveScrollPosition();
            break;

          case EnumNavigationStatus.navigation:
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (_) => const ToleranceSelectionScreen(),
              ),
            );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(localization.select_pitch),
        ),
        body: Stack(
          children: [
            BlocBuilder<PitchBloc, PitchState>(
              builder: (context, state) {
                switch (state.enumPageStatus) {
                  case EnumStatus.loading:
                  case EnumStatus.initial:
                    return const LoadingWidget();

                  case EnumStatus.error:
                    return MyErrorWidget(
                      errorMsg: state.errorMsg,
                      onRetry: () => context.read<PitchBloc>().loadPitch(),
                    );

                  case EnumStatus.success:
                    return ListView.separated(
                      itemCount: state.pitches.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 8.0),
                      itemBuilder: (context, index) {
                        final pitch = state.pitches[index];
                        return PitchChoiceCard(
                          pitch: pitch,
                          onTap: pitch.enumPitchDataType == EnumPitchDataType.value
                              ? () => context.read<PitchBloc>().preparationNavigation(pitch)
                              : null,
                        );
                      },
                    );
                }
              },
            ),
            BlocBuilder<PitchBloc, PitchState>(
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
