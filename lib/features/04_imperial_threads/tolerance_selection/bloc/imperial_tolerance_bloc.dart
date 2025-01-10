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
import 'package:threadfon/features/04_imperial_threads/models/imperial_user_selection.dart';
import 'package:threadfon/features/04_imperial_threads/tolerance_selection/models/imperial_tolerance_model.dart';
import 'package:threadfon/features/04_imperial_threads/tolerance_selection/repositories/imperial_tolerance_repository.dart';

part 'imperial_tolerance_bloc.freezed.dart';
part 'imperial_tolerance_bloc.g.dart';
part 'imperial_tolerance_state.dart';

final LogService _logger = LogService('imperial_tolerance_bloc');

class ImperialToleranceBloc extends Cubit<ImperialToleranceState>
    with BlocIgnoreEmitAfterClosed {
  ImperialToleranceBloc({
    required Imperial repository,
    required LocalStorage localStorage,
    required LanguageBloc languageBloc,
  })  : _repository = repository,
        _localStorage = localStorage,
        _languageBloc = languageBloc,
        super(const ImperialToleranceState());

  final Imperial _repository;
  final LocalStorage _localStorage;
  final LanguageBloc _languageBloc;

  Future<void> load() async {
    emit(state.copyWith(enumPageStatus: EnumStatus.loading));
    try {
      final ImperialUserSelection imperialUserSelection =
          await _localStorage.getImperialUserSelection();
      final CoreUserSelection coreUserSelection =
          await _localStorage.getCoreUserSelection();
      final ImperialToleranceModel tolerancesResponse =
          await _repository.fetchTolerances(
        tpi: imperialUserSelection.tpi!,
        diameter: imperialUserSelection.diameter!,
      );
      emit(state.copyWith(
        enumPageStatus: EnumStatus.success,
        femaleTolerances: tolerancesResponse.female,
        maleTolerances: tolerancesResponse.male,
        selectedThreadType: coreUserSelection.threadType,
      ));
    } catch (e, s) {
      _logger.e('Error loading tolerances', error: e, stackTrace: s);

      _setErrorState();
    }
  }

  Future<void> preparationNavigation(
      ImperialToleranceItem selectedTolerance, bool isFemale) async {
    try {
      await _localStorage.updateImperialUserSelection(
        (ImperialUserSelection current) => current.copyWith(
          series: selectedTolerance.series,
        ),
      );
      emit(state.copyWith(
          enumNavigationStatus: EnumNavigationStatus.navigation));
    } catch (e, s) {
      _logger.e('Error updating tolerance selection', error: e, stackTrace: s);

      _setErrorState();
    }
  }

  // Новый метод для обновления выбранного пола
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
        ? 'An error occurred while loading tolerances.'
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
