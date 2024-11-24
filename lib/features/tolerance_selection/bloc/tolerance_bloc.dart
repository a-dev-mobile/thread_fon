import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:threadfon/app/language/language_bloc.dart';
import 'package:threadfon/core/constant/enum_navigation.dart';
import 'package:threadfon/core/constant/enum_status.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/features/tolerance_selection/models/tolerance_model.dart';
import 'package:threadfon/features/tolerance_selection/repositories/tolerance_repository.dart';

part 'tolerance_bloc.freezed.dart';
part 'tolerance_bloc.g.dart';
part 'tolerance_state.dart';

final _logger = LogService('tolerance_controller');

class ToleranceBloc extends Cubit<ToleranceState> {
  ToleranceBloc({
    required ToleranceRepository repository,
    required LocalStorage localStorage,
    required LanguageBloc languageBloc,
  })  : _repository = repository,
        _localStorage = localStorage,
        _languageBloc = languageBloc,
        super(const ToleranceState());

  final ToleranceRepository _repository;
  final LocalStorage _localStorage;
  final LanguageBloc _languageBloc;

  Future<void> loadTolerances() async {
    emit(state.copyWith(enumPageStatus: EnumStatus.loading));
    try {
      final userSelection = await _localStorage.getUserSelection();
      final tolerances = await _repository.fetchTolerances(
        id: userSelection.id!,
        threadType: userSelection.threadType!.name,
      );
      emit(state.copyWith(
          enumPageStatus: EnumStatus.success, tolerances: tolerances));
    } catch (e, s) {
      _logger.e('Error loading tolerances', error: e, stackTrace: s);
      _setErrorState();
    }
  }

  Future<void> preparationNavigation(ToleranceModel selectedTolerance) async {
    try {
      await _localStorage.updateUserSelection(
        (current) => current.copyWith(
          tolerance: selectedTolerance.tolerance,
        ),
      );
      emit(state.copyWith(
          enumNavigationStatus: EnumNavigationStatus.navigation));
      await Future<void>.delayed(const Duration(milliseconds: 100));
      emit(state.copyWith(enumNavigationStatus: EnumNavigationStatus.initial));
    } catch (e, s) {
      _logger.e('Error updating tolerance selection', error: e, stackTrace: s);
      _setErrorState();
    }
  }

  void _setErrorState() {
    final currentLang = _languageBloc.state.enumLang;
    final errorMsg = currentLang == EnumLang.en
        ? 'An error occurred while loading tolerances.'
        : 'Произошла ошибка при загрузке допусков.';
    emit(state.copyWith(
        enumPageStatus: EnumStatus.error,
        errorMsg: errorMsg,
        enumNavigationStatus: EnumNavigationStatus.initial));
  }
}
