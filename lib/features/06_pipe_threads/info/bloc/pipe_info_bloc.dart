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
import 'package:threadfon/features/06_pipe_threads/core/models/pipe_user_selection.dart';
import 'package:threadfon/features/06_pipe_threads/info/models/pipe_info_model.dart';
import 'package:threadfon/features/06_pipe_threads/info/repositories/pipe_info_repository.dart';




part 'pipe_info_bloc.freezed.dart';
part 'pipe_info_bloc.g.dart';
part 'pipe_info_state.dart';

final LogService _logger = LogService('pipe_info_bloc');

class PipeInfoBloc extends Cubit<PipeInfoState>
    with BlocIgnoreEmitAfterClosed<PipeInfoState> {
  PipeInfoBloc({
    required PipeInfoRepository repository,
    required LocalStorage localStorage,
    required LanguageBloc languageBloc,
    required ThemeBloc themeBloc,
  })  : _repository = repository,
        _localStorage = localStorage,
        _languageBloc = languageBloc,
        _themeBloc = themeBloc,
        super(const PipeInfoState());

  final PipeInfoRepository _repository;
  final ThemeBloc _themeBloc;
  final LocalStorage _localStorage;
  final LanguageBloc _languageBloc;

  Future<void> load() async {
    emit(state.copyWith(
      enumPageStatus: EnumStatus.loading,
      svgRequestStatus: EnumStatus.loading,
    ));
    try {
      final PipeUserSelection pipeUserSelection =
          await _localStorage.getPipeUserSelection();
      final CoreUserSelection coreUserSelection =
          await _localStorage.getCoreUserSelection();
      final PipeInfoModel model =
          await _fetchModel(coreUserSelection, pipeUserSelection);
      emit(state.copyWith(
        enumPageStatus: EnumStatus.success,
        model: model,
        units: pipeUserSelection.units,
        precision: pipeUserSelection.precision,
        isSvgOverlayVisible: coreUserSelection.isSvgOverlayVisible,
      ));

      // Start fetching SVG data in the background
      await _fetchSvgData(coreUserSelection, pipeUserSelection);
    } catch (e, s) {
      _logger.e(
        'Error loading info',
        error: e,
        stackTrace: s,
      );
      _setErrorState();
    }
  }

  Future<PipeInfoModel> _fetchModel(CoreUserSelection coreUserSelection,
      PipeUserSelection trapezoidUserSelection) async {
    return await _repository.fetchPipeInfo(
      diameter:' trapezoidUserSelection.diameter!',
      pitch: 'trapezoidUserSelection.pitch!',
      type: coreUserSelection.threadType.name,
      tolerance: 'trapezoidUserSelection.tolerance!',
      language: _languageBloc.state.enumLang.name,
      units: trapezoidUserSelection.units.name,
      precision: trapezoidUserSelection.precision,
    );
  }

  Future<void> _fetchSvgData(CoreUserSelection coreUserSelection,
      PipeUserSelection pipeUserSelection) async {
    emit(state.copyWith(svgRequestStatus: EnumStatus.loading));
    try {
      final String theme = _themeBloc.state.themeMode.name;
      final String language = _languageBloc.state.enumLang.name;

      final Future<String> fetchSvgDimensions = _repository.fetchSvgDimensions(
        diameter:' pipeUserSelection.diameter!',
        pitch:' pipeUserSelection.pitch!',
        type: coreUserSelection.threadType.name,
        tolerance: 'pipeUserSelection.tolerance!',
        language: language,
        units: pipeUserSelection.units.name,
        precision: pipeUserSelection.precision,
        theme: theme,
      );

      final Future<String> fetchSvgAnnotations =
          _repository.fetchSvgAnnotations(
        type: coreUserSelection.threadType.name,
        language: language,
        theme: theme,
      );

      final List<String> results = await Future.wait<String>(<Future<String>>[
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
      // await _localStorage.updatePipeUserSelection(
      //   (current) => current.copyWith(
      //     id: state.model?.id,
      //   ),
      // );
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
    await _localStorage.updatePipeUserSelection(
        (PipeUserSelection current) =>
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
