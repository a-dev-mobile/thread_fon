import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:threadfon/app/language/language_bloc.dart';
import 'package:threadfon/core/constant/enum_status.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/features/pitch_selection/models/pitch_model.dart';
import 'package:threadfon/features/pitch_selection/repositories/pitch_repository.dart';

part 'pitch_bloc.freezed.dart';
part 'pitch_bloc.g.dart';
part 'pitch_state.dart';

final _logger = LogService('pitch_bloc');

class PitchBloc extends Cubit<PitchState> {
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
    emit(state.copyWith(status: EnumStatus.loading));
    try {
      final userSelection = await _localStorage.getUserSelection();
      final pitchList = await _repository.fetchPitch(
        diameter: userSelection.diameter!,
        language: _languageBloc.state.enumLang.name,
      );
      emit(state.copyWith(status: EnumStatus.success, pitches: pitchList));
    } catch (e, s) {
      _logger.e('Error loading pitch', error: e, stackTrace: s);
      _setErrorState();
    }
  }

  Future<void> selectPitch(PitchModel selectedPitch) async {
    emit(state.copyWith(status: EnumStatus.preparingNavigation));

    try {
      await _localStorage.updateUserSelection(
        (current) => current.copyWith(
          id: selectedPitch.id,
          pitch: selectedPitch.pitch,
        ),
      );
      emit(state.copyWith(status: EnumStatus.navigating));
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(state.copyWith(status: EnumStatus.success));
    } catch (e, s) {
      _logger.e('Error updating pitch selection', error: e, stackTrace: s);
      _setErrorState();
    }
  }

  void _setErrorState() {
    final currentLang = _languageBloc.state.enumLang;
    final errorMsg = currentLang == EnumLang.en
        ? 'An error occurred while loading pitches.'
        : 'Произошла ошибка при загрузке шагов резьбы.';
    emit(state.copyWith(status: EnumStatus.error, errorMsg: errorMsg));
  }
}
