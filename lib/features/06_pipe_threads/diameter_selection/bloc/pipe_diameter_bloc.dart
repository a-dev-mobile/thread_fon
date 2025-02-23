import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:threadfon/app/language/language_bloc.dart';
import 'package:threadfon/core/constant/enum_lang.dart';
import 'package:threadfon/core/constant/enum_navigation_status.dart';
import 'package:threadfon/core/constant/enum_status.dart';
import 'package:threadfon/core/constant/enum_thread_male_female.dart';
import 'package:threadfon/core/mixins/bloc_ignore_emit_after_closed.dart';
import 'package:threadfon/core/models/core_user_selection.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/features/06_pipe_threads/core/models/pipe_user_selection.dart';
import 'package:threadfon/features/06_pipe_threads/diameter_selection/models/pipe_diameter_model.dart';

import 'package:threadfon/features/06_pipe_threads/diameter_selection/repositories/pipe_diameter_repository.dart';

part 'pipe_diameter_bloc.freezed.dart';
part 'pipe_diameter_bloc.g.dart';
part 'pipe_diameter_state.dart';

final LogService _logger = LogService('pipe_diameter_bloc');

class PipeDiameterBloc extends Cubit<PipeDiameterState>
    // ignore: always_specify_types
    with
        BlocIgnoreEmitAfterClosed {
  PipeDiameterBloc({
    required PipeDiameterRepository repository,
    required LocalStorage localStorage,
    required LanguageBloc languageBloc,
  })  : _repository = repository,
        _localStorage = localStorage,
        _languageBloc = languageBloc,
        super(const PipeDiameterState());

  final PipeDiameterRepository _repository;
  final LocalStorage _localStorage;
  final LanguageBloc _languageBloc;

  Future<void> load() async {
    emit(state.copyWith(enumPageStatus: EnumStatus.loading));
    try {
      final PipeUserSelection threadUserSelection =
          await _localStorage.getPipeUserSelection();
      final CoreUserSelection coreUserSelection =
          await _localStorage.getCoreUserSelection();
      final PipeDiameterModel diametersResponse =
          await _repository.fetchDiameters();
      emit(state.copyWith(
        enumPageStatus: EnumStatus.success,
        femaleDiameters: diametersResponse.female,
        maleDiameters: diametersResponse.male,
        selectedThreadType: coreUserSelection.threadType,
      ));
    } catch (e, s) {
      _logger.e('Error loading diameters', error: e, stackTrace: s);
      _setErrorState();
    }
  }

  Future<void> preparationNavigation(PipeDiameterItem selectedDiameter) async {
    try {
      await _localStorage.updatePipeUserSelection(
        (PipeUserSelection current) => current.copyWith(
          id: selectedDiameter.id,
        ),
      );
      emit(state.copyWith(
          enumNavigationStatus: EnumNavigationStatus.navigation));
    } catch (e, s) {
      _logger.e('Error updating diameter selection', error: e, stackTrace: s);
      _setErrorState();
    }
  }

  Future<void> updateGenderSelection(EnumThreadMaleFemale threadType) async {
    try {
      await _localStorage.updateCoreUserSelection(
        (CoreUserSelection current) => current.copyWith(
          threadType: threadType,
        ),
      );
      emit(state.copyWith(selectedThreadType: threadType));
    } catch (e, s) {
      _logger.e('Error updating gender selection', error: e, stackTrace: s);
    }
  }

  void _setErrorState() {
    final EnumLang currentLang = _languageBloc.state.enumLang;
    final String errorMsg = currentLang == EnumLang.en
        ? 'An error occurred while loading diameters.'
        : 'Произошла ошибка при загрузке допусков.';
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
