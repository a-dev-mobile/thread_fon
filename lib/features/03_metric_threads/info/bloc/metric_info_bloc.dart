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
import 'package:threadfon/features/03_metric_threads/core/models/metric_user_selection.dart';
import 'package:threadfon/features/03_metric_threads/info/models/metric_info_model.dart';
import 'package:threadfon/features/03_metric_threads/info/repositories/metric_info_repository.dart';

part 'metric_info_bloc.freezed.dart';
part 'metric_info_bloc.g.dart';
part 'metric_info_state.dart';

final LogService _logger = LogService('info_bloc');

class MetricInfoBloc extends Cubit<MetricInfoState>
    with BlocIgnoreEmitAfterClosed {
  MetricInfoBloc({
    required MetricInfoRepository repository,
    required LocalStorage localStorage,
    required LanguageBloc languageBloc,
    required ThemeBloc themeBloc,
  })  : _repository = repository,
        _localStorage = localStorage,
        _languageBloc = languageBloc,
        _themeBloc = themeBloc,
        super(const MetricInfoState());

  final MetricInfoRepository _repository;
  final ThemeBloc _themeBloc;
  final LocalStorage _localStorage;
  final LanguageBloc _languageBloc;

  Future<void> load() async {
    emit(state.copyWith(
      enumPageStatus: EnumStatus.loading,
      svgRequestStatus: EnumStatus.loading,
    ));
    try {
      final MetricUserSelection metricUserSelection =
          await _localStorage.getMetricUserSelection();
      final CoreUserSelection coreUserSelection =
          await _localStorage.getCoreUserSelection();
      final MetricInfoModel model =
          await _fetchModel(coreUserSelection, metricUserSelection);
      emit(state.copyWith(
        enumPageStatus: EnumStatus.success,
        model: model,
        units: metricUserSelection.units,
        precision: metricUserSelection.precision,
        isSvgOverlayVisible: coreUserSelection.isSvgOverlayVisible,
      ));

      // Start fetching SVG data in the background
      await _fetchSvgData(coreUserSelection, metricUserSelection);
    } catch (e, s) {
      _logger.e('Error loading info', error: e, stackTrace: s);

      _setErrorState();
    }
  }

  Future<MetricInfoModel> _fetchModel(CoreUserSelection coreUserSelection,
      MetricUserSelection metricUserSelection) async {
    return await _repository.fetchInfo(
      diameter: metricUserSelection.diameter!,
      pitch: metricUserSelection.pitch!,
      threadType: coreUserSelection.threadType.name,
      tolerance: metricUserSelection.tolerance!,
      language: _languageBloc.state.enumLang.name,
      units: metricUserSelection.units.name,
      precision: metricUserSelection.precision,
    );
  }

  Future<void> _fetchSvgData(CoreUserSelection coreUserSelection,
      MetricUserSelection metricUserSelection) async {
    emit(state.copyWith(svgRequestStatus: EnumStatus.loading));
    try {
      final String theme = _themeBloc.state.themeMode.name;
      final String language = _languageBloc.state.enumLang.name;

      final Future<String> fetchSvgWithDimensions = _repository.fetchSvgData(
        diameter: metricUserSelection.diameter!,
        pitch: metricUserSelection.pitch!,
        threadType: coreUserSelection.threadType.name,
        tolerance: metricUserSelection.tolerance!,
        theme: theme,
        units: metricUserSelection.units.name,
        precision: metricUserSelection.precision,
        language: language,
        showDimensions: true,
      );

      final Future<String> fetchSvgWithoutDimensions = _repository.fetchSvgData(
        diameter: metricUserSelection.diameter!,
        pitch: metricUserSelection.pitch!,
        threadType: coreUserSelection.threadType.name,
        tolerance: metricUserSelection.tolerance!,
        theme: theme,
        units: metricUserSelection.units.name,
        precision: metricUserSelection.precision,
        language: language,
        showDimensions: false,
      );

      final List<String> results = await Future.wait(<Future<String>>[
        fetchSvgWithDimensions,
        fetchSvgWithoutDimensions,
      ]);

      emit(state.copyWith(
        svgData: results[0],
        svgDataNoDimensions: results[1],
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
      await _localStorage.updateMetricUserSelection(
        (MetricUserSelection current) => current.copyWith(
          id: state.model?.id,
        ),
      );
      emit(state.copyWith(
          enumNavigationStatus: EnumNavigationStatus.navigation));
      await Future<void>.delayed(const Duration(milliseconds: 100));
      emit(state.copyWith(enumNavigationStatus: EnumNavigationStatus.initial));
    } catch (e, s) {
      _logger.e('Error updating selection', error: e, stackTrace: s);

      _setErrorState();
    }
  }

  Future<void> updateUnitsPrecision(
      {required EnumUnits units, required int precision}) async {
    await _localStorage.updateMetricUserSelection(
        (MetricUserSelection current) =>
            current.copyWith(units: units, precision: precision));
    await load();
  }

  void toggleSvgOverlay() {
    bool isSvgOverlayVisible = !state.isSvgOverlayVisible;
    emit(state.copyWith(isSvgOverlayVisible: isSvgOverlayVisible));
    _localStorage.updateCoreUserSelection((CoreUserSelection current) =>
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
