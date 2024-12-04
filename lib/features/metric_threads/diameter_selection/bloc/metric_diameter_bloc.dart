import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:threadfon/app/language/language_bloc.dart';
import 'package:threadfon/core/constant/enum_navigation.dart';
import 'package:threadfon/core/constant/enum_status.dart';
import 'package:threadfon/core/mixins/bloc_ignore_emit_after_closed.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';
import 'package:threadfon/core/services/logging/logger.dart';

import 'package:threadfon/features/metric_threads/diameter_selection/models/metric_diameter_model.dart';
import 'package:threadfon/features/metric_threads/diameter_selection/repositories/metric_diameter_repository.dart';

part 'metric_diameter_bloc.freezed.dart';
part 'metric_diameter_bloc.g.dart';
part 'metric_diameter_state.dart';

final _logger = LogService('metric_diameter_bloc');

class MetricDiameterBloc extends Cubit<MetricDiameterState>
    with BlocIgnoreEmitAfterClosed {
  MetricDiameterBloc({
    required DiameterRepository repository,
    required LocalStorage localStorage,
    required LanguageBloc languageBloc,
  })  : _repository = repository,
        _localStorage = localStorage,
        _languageBloc = languageBloc,
        super(const MetricDiameterState());

  final DiameterRepository _repository;
  final LocalStorage _localStorage;
  final LanguageBloc _languageBloc;

  Future<void> load() async {
    emit(state.copyWith(enumPageStatus: EnumStatus.loading));
    try {
      final diameters = await _repository.fetchDiameters();
      final scrollPosition = await _localStorage.getScrollPosition();

      emit(state.copyWith(
        enumPageStatus: EnumStatus.success,
        diameters: diameters,
        scrollPosition: scrollPosition,
      ));
    } catch (e, s) {
      _logger.e('Error loading diameters', error: e, stackTrace: s);

      _setErrorState();
    }
  }

  Future<void> preparationNavigation(
      MetricDiameterModel selectedDiameter, double scrollPosition) async {
    await _localStorage.setScrollPosition(scrollPosition);
    try {
      await _localStorage.updateUserSelection(
        (current) => current.copyWith(
          id: selectedDiameter.id,
          diameter: selectedDiameter.diameter,
        ),
      );
      emit(state.copyWith(
          enumNavigationStatus: EnumNavigationStatus.navigation));
      // Удалили задержку
    } catch (e, s) {
      _logger.e('Error updating selection', error: e, stackTrace: s);
      _setErrorState();
    }
  }

  void resetNavigationStatus() {
    emit(state.copyWith(
      enumNavigationStatus: EnumNavigationStatus.initial,
    ));
  }

  void _setErrorState() {
    final currentLang = _languageBloc.state.enumLang;
    final errorMsg = currentLang == EnumLang.en
        ? 'An error occurred while loading diameters.'
        : 'Произошла ошибка при загрузке диаметров.';
    emit(state.copyWith(
        enumPageStatus: EnumStatus.error,
        errorMsg: errorMsg,
        enumNavigationStatus: EnumNavigationStatus.initial));
  }
}
