import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:threadfon/app/language/language_bloc.dart';
import 'package:threadfon/app/theme/theme_bloc.dart';
import 'package:threadfon/core/constant/enum_lang.dart';
import 'package:threadfon/core/constant/enum_navigation_status.dart';
import 'package:threadfon/core/constant/enum_status.dart';
import 'package:threadfon/core/constant/enum_units.dart';
import 'package:threadfon/core/mixins/bloc_ignore_emit_after_closed.dart';
import 'package:threadfon/core/models/core_user_selection.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/features/04_imperial_threads/info/models/imperial_info_model.dart';
import 'package:threadfon/features/04_imperial_threads/info/repositories/imperial_info_repository.dart';
import 'package:threadfon/features/04_imperial_threads/models/imperial_user_selection.dart';

part 'imperial_info_bloc.freezed.dart';
part 'imperial_info_bloc.g.dart';
part 'imperial_info_state.dart';

final LogService _logger = LogService('imperial_info_bloc');

class ImperialInfoBloc extends Cubit<ImperialInfoState>
    with BlocIgnoreEmitAfterClosed<ImperialInfoState> {
  ImperialInfoBloc({
    required ImperialInfoRepository repository,
    required LocalStorage localStorage,
    required LanguageBloc languageBloc,
    required ThemeBloc themeBloc,
  })  : _repository = repository,
        _localStorage = localStorage,
        _languageBloc = languageBloc,
        _themeBloc = themeBloc,
        super(const ImperialInfoState());

  final ImperialInfoRepository _repository;
  final ThemeBloc _themeBloc;
  final LocalStorage _localStorage;
  final LanguageBloc _languageBloc;

  Future<void> load() async {
    emit(state.copyWith(
      enumPageStatus: EnumStatus.loading,
      svgRequestStatus: EnumStatus.loading,
    ));
    try {
      final ImperialUserSelection imperialUserSelection =
          await _localStorage.getImperialUserSelection();
      final CoreUserSelection coreUserSelection =
          await _localStorage.getCoreUserSelection();
      final ImperialInfoModel model =
          await _fetchModel(coreUserSelection, imperialUserSelection);
      emit(state.copyWith(
        enumPageStatus: EnumStatus.success,
        model: model,
        units: imperialUserSelection.units,
        precision: imperialUserSelection.precision,
        isSvgOverlayVisible: imperialUserSelection.isSvgOverlayVisible,
      ));

      // Start fetching SVG data in the background
      // _fetchSvgData(coreUserSelection, imperialUserSelection);
    } catch (e, s) {
      _logger.e(
        'Error loading info',
        error: e,
        stackTrace: s,
      );
      _setErrorState();
    }
  }

  Future<ImperialInfoModel> _fetchModel(CoreUserSelection coreUserSelection,
      ImperialUserSelection imperialUserSelection) async {
    return await _repository.fetchImperialInfo(
      diameter: imperialUserSelection.diameter!,
      tpi: imperialUserSelection.tpi!,
      series: imperialUserSelection.series!,
      type: coreUserSelection.threadType.name,
      language: _languageBloc.state.enumLang.name,
      units: imperialUserSelection.units.name,
      precision: imperialUserSelection.precision,
    );
  }

  Future<void> _fetchSvgData(CoreUserSelection coreUserSelection,
      ImperialUserSelection imperialUserSelection) async {
    emit(state.copyWith(svgRequestStatus: EnumStatus.loading));
    try {
      final String theme = _themeBloc.state.themeMode.name;
      final String language = _languageBloc.state.enumLang.name;

      final Future<String> fetchSvgDimensions = _repository.fetchSvgDimensions(
        diameter: imperialUserSelection.diameter!,
        tpi: imperialUserSelection.tpi!,
        series: imperialUserSelection.series!,
        type: coreUserSelection.threadType.name,
        language: language,
        units: imperialUserSelection.units.name,
        precision: imperialUserSelection.precision,
        theme: theme,
      );

      final Future<String> fetchSvgAnnotations =
          _repository.fetchSvgAnnotations(
        type: coreUserSelection.threadType.name,
        language: language,
        theme: theme,
      );

      final List<String> results = await Future.wait<String>([
        fetchSvgDimensions,
        fetchSvgAnnotations,
      ]);

      emit(state.copyWith(
        svgDimensions: results.first,
        svgAnnotations: results[1],
        svgRequestStatus: EnumStatus.success,
      ));
    } catch (e, s) {
      _logger.e('Error fetching SVG data', error: e, stackTrace: s);
      emit(state.copyWith(
        svgRequestStatus: EnumStatus.error,
        svgErrorMsg: 'Error loading SVG data',
      ));
    }
  }

  Future<void> preparationNavigation() async {
    try {
      emit(state.copyWith(
          enumNavigationStatus: EnumNavigationStatus.navigation));
      await Future<void>.delayed(const Duration(milliseconds: 100));
      emit(state.copyWith(enumNavigationStatus: EnumNavigationStatus.initial));
    } catch (e, s) {
      _logger.e(
        'Error updating selection',
        error: e,
        stackTrace: s,
      );
      _setErrorState();
    }
  }

  Future<void> updateUnitsPrecision(
      {required EnumUnits units, required int precision}) async {
    await _localStorage.updateImperialUserSelection(
        (ImperialUserSelection current) =>
            current.copyWith(units: units, precision: precision));
    await load();
  }

  void toggleSvgOverlay() {
    bool isSvgOverlayVisible = !state.isSvgOverlayVisible;
    emit(state.copyWith(isSvgOverlayVisible: isSvgOverlayVisible));
    _localStorage.updateImperialUserSelection((ImperialUserSelection current) =>
        current.copyWith(isSvgOverlayVisible: isSvgOverlayVisible));
  }

  void toggleDimensions() {
    emit(state.copyWith(showDimensions: !state.showDimensions));
  }

  void _setErrorState() {
    final EnumLang currentLang = _languageBloc.state.enumLang;
    final String errorMsg = currentLang == EnumLang.en
        ? 'An error occurred while loading info.'
        : 'Произошла ошибка при загрузке информации.';
    emit(state.copyWith(
        enumPageStatus: EnumStatus.error,
        errorMsg: errorMsg,
        enumNavigationStatus: EnumNavigationStatus.initial));
  }
}
