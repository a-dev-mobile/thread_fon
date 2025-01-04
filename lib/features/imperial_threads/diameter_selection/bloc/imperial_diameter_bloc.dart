import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:threadfon/app/language/language_bloc.dart';
import 'package:threadfon/core/constant/enum_lang.dart';
import 'package:threadfon/core/constant/enum_navigation_status.dart';
import 'package:threadfon/core/constant/enum_status.dart';
import 'package:threadfon/core/mixins/bloc_ignore_emit_after_closed.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/features/imperial_threads/diameter_selection/models/imperial_diameter_model.dart';
import 'package:threadfon/features/imperial_threads/diameter_selection/repositories/imperial_diameter_repository.dart';
import 'package:threadfon/features/imperial_threads/models/imperial_user_selection.dart';

part 'imperial_diameter_bloc.freezed.dart';
part 'imperial_diameter_bloc.g.dart';
part 'imperial_diameter_state.dart';

final LogService _logger = LogService('imperial_diameter_bloc');

class ImperialDiameterBloc extends Cubit<ImperialDiameterState>
    with BlocIgnoreEmitAfterClosed {
  ImperialDiameterBloc({
    required DiameterRepository repository,
    required LocalStorage localStorage,
    required LanguageBloc languageBloc,
  })  : _repository = repository,
        _localStorage = localStorage,
        _languageBloc = languageBloc,
        super(const ImperialDiameterState());

  final DiameterRepository _repository;
  final LocalStorage _localStorage;
  final LanguageBloc _languageBloc;

  Future<void> load() async {
    emit(state.copyWith(enumPageStatus: EnumStatus.loading));
    try {
      final List<ImperialDiameterModel> diameters =
          await _repository.fetchDiameters();
      final double scrollPosition =
          await _localStorage.getImperialScrollPosition();

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
      ImperialDiameterModel model, double scrollPosition) async {
    await _localStorage.setImperialScrollPosition(scrollPosition);
    try {
      await _localStorage.updateImperialUserSelection(
        (ImperialUserSelection current) => current.copyWith(
          diameter: model.diameter,
          tpi: model.tpi,
          series: model.series,
        ),
      );
      emit(state.copyWith(
          enumNavigationStatus: EnumNavigationStatus.navigation));
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
    final EnumLang currentLang = _languageBloc.state.enumLang;
    final String errorMsg = currentLang == EnumLang.en
        ? 'An error occurred while loading diameters.'
        : 'Произошла ошибка при загрузке диаметров.';
    emit(state.copyWith(
        enumPageStatus: EnumStatus.error,
        errorMsg: errorMsg,
        enumNavigationStatus: EnumNavigationStatus.initial));
  }
}
