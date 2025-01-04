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
import 'package:threadfon/features/metric_threads/pitch_selection/bloc/pitch_bloc.dart';
import 'package:threadfon/features/metric_threads/pitch_selection/models/pitch_model.dart';
import 'package:threadfon/features/metric_threads/pitch_selection/repositories/pitch_repository.dart';
import 'package:threadfon/features/metric_threads/pitch_selection/views/pitch_choice_card.dart';
import 'package:threadfon/features/metric_threads/tolerance_selection/views/tolerance_selection_screen.dart';
import 'package:threadfon/localization/generated/l10n.dart';
import 'package:threadfon/localization/l10n_extension.dart';

final LogService _logger = LogService('metric_pitch_screen');

class PitchSelectionScreen extends StatefulWidget {
  const PitchSelectionScreen({super.key});
  static const String path = '/PitchSelectionScreen';
  static const String name = 'PitchSelectionScreen';

  @override
  State<PitchSelectionScreen> createState() => _PitchSelectionScreenState();
}

class _PitchSelectionScreenState extends State<PitchSelectionScreen> {
  late PitchBloc _bloc;
  @override
  void initState() {
    super.initState();
    final ApiService apiService = context.read<ApiService>();
    final PitchRepository pitchRepository =
        PitchRepository(apiService: apiService);
    final LocalStorage localStorage = context.read<LocalStorage>();
    final LanguageBloc languageBloc = context.read<LanguageBloc>();
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
    final GeneratedLocalization localization = context.l10n;

    return BlocListener<PitchBloc, PitchState>(
      listenWhen: (PitchState previous, PitchState current) =>
          previous.enumNavigationStatus != current.enumNavigationStatus,
      listener: (BuildContext context, PitchState state) {
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
          children: <Widget>[
            BlocBuilder<PitchBloc, PitchState>(
              builder: (BuildContext context, PitchState state) {
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
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(height: 8.0),
                      itemBuilder: (BuildContext context, int index) {
                        final PitchModel pitch = state.pitches[index];
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
