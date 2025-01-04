import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:threadfon/app/language/language_bloc.dart';
import 'package:threadfon/core/constant/enum_lang.dart';
import 'package:threadfon/core/constant/enum_navigation_status.dart';
import 'package:threadfon/core/constant/enum_status.dart';
import 'package:threadfon/core/mixins/bloc_ignore_emit_after_closed.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/features/metric_threads/core/models/metric_user_selection.dart';
import 'package:threadfon/features/metric_threads/pitch_selection/models/pitch_model.dart';
import 'package:threadfon/features/metric_threads/pitch_selection/repositories/pitch_repository.dart';

part 'pitch_bloc.freezed.dart';
part 'pitch_bloc.g.dart';
part 'pitch_state.dart';

final LogService _logger = LogService('pitch_bloc');

class PitchBloc extends Cubit<PitchState> with BlocIgnoreEmitAfterClosed {
  PitchBloc({
    required PitchRepository repository,
    required LocalStorage localStorage,
    required LanguageBloc languageBloc,
  })  : _repository = repository,
        _localStorage = localStorage,
        _languageBloc = languageBloc,
        super(const PitchState());

  final PitchRepository _repository;
  final LocalStorage _localStorage;
  final LanguageBloc _languageBloc;

  Future<void> loadPitch() async {
    emit(state.copyWith(enumPageStatus: EnumStatus.loading));
    try {
      final MetricUserSelection metricUserSelection =
          await _localStorage.getMetricUserSelection();
      final List<PitchModel> pitchList = await _repository.fetchPitch(
        diameter: metricUserSelection.diameter!,
        language: _languageBloc.state.enumLang.name,
      );
      emit(state.copyWith(
          enumPageStatus: EnumStatus.success, pitches: pitchList));
    } catch (e, s) {
      _logger.e('Error loading pitch', error: e, stackTrace: s);

      _setErrorState();
    }
  }

  Future<void> preparationNavigation(PitchModel selectedPitch) async {
    try {
      await _localStorage.updateMetricUserSelection(
        (MetricUserSelection current) => current.copyWith(
          id: selectedPitch.id,
          pitch: selectedPitch.pitch,
        ),
      );
      emit(state.copyWith(
          enumNavigationStatus: EnumNavigationStatus.navigation));
    } catch (e, s) {
      _logger.e('Error updating pitch selection', error: e, stackTrace: s);

      _setErrorState();
    }
  }

  void _setErrorState() {
    final EnumLang currentLang = _languageBloc.state.enumLang;
    final String errorMsg = currentLang == EnumLang.en
        ? 'An error occurred while loading pitches.'
        : 'Произошла ошибка при загрузке шагов резьбы.';
    emit(state.copyWith(
        enumPageStatus: EnumStatus.error,
        errorMsg: errorMsg,
        enumNavigationStatus: EnumNavigationStatus.initial));
  }

  void resetNavigationStatus() {
    emit(state.copyWith(
      enumNavigationStatus: EnumNavigationStatus.initial,
    ));
  }
}
