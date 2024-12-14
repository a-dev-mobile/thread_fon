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
import 'package:threadfon/features/metric_threads/pitch_selection/bloc/pitch_bloc.dart';
import 'package:threadfon/features/metric_threads/pitch_selection/models/pitch_model.dart';
import 'package:threadfon/features/metric_threads/pitch_selection/repositories/pitch_repository.dart';
import 'package:threadfon/features/metric_threads/pitch_selection/views/pitch_choice_card.dart';
import 'package:threadfon/features/metric_threads/tolerance_selection/views/tolerance_selection_screen.dart';
import 'package:threadfon/localization/l10n_extension.dart';

final _logger = LogService('metric_pitch_screen');

class PitchSelectionScreen extends StatefulWidget {
  const PitchSelectionScreen({super.key});
  static const path = '/PitchSelectionScreen';
  static const name = 'PitchSelectionScreen';

  @override
  State<PitchSelectionScreen> createState() => _PitchSelectionScreenState();
}

class _PitchSelectionScreenState extends State<PitchSelectionScreen> {
  late PitchBloc _bloc;
  @override
  void initState() {
    super.initState();
    final apiService = context.read<ApiService>();
    final pitchRepository = PitchRepository(apiService: apiService);
    final localStorage = context.read<LocalStorage>();
    final languageBloc = context.read<LanguageBloc>();
    _bloc = PitchBloc(
      repository: pitchRepository,
      localStorage: localStorage,
      languageBloc: languageBloc,
    )..loadPitch();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _bloc,
      child: _PitchSelectionView(_bloc),
    );
  }
}

class _PitchSelectionView extends StatelessWidget {
  const _PitchSelectionView(this.bloc);
  final PitchBloc bloc;
  @override
  Widget build(BuildContext context) {
    final localization = context.l10n;

    return BlocListener<PitchBloc, PitchState>(
      listenWhen: (previous, current) =>
          previous.enumNavigationStatus != current.enumNavigationStatus,
      listener: (context, state) {
        if (state.enumNavigationStatus.isNavigation) {
          context.pushNamed(ToleranceSelectionScreen.name);

          // Сброс статуса навигации через публичный метод
          bloc.resetNavigationStatus();
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
                    return const LoadingWidget();

                  case EnumStatus.error:
                    return MyErrorWidget(
                      errorMsg: state.errorMsg,
                      onRetry: () => context.read<PitchBloc>().loadPitch(),
                    );

                  case EnumStatus.success:
                    return ListView.separated(
                      itemCount: state.pitches.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 8.0),
                      itemBuilder: (context, index) {
                        final pitch = state.pitches[index];
                        return PitchChoiceCard(
                          pitch: pitch,
                          onTap: () {
                            if (pitch.enumPitchDataType ==
                                EnumPitchDataType.value) {
                              bloc.preparationNavigation(pitch);
                            }
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
