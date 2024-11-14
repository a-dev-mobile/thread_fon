import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:threadfon/app/language/language_bloc.dart';
import 'package:threadfon/app/theme/theme_bloc.dart';
import 'package:threadfon/core/constant/enum_navigation.dart';
import 'package:threadfon/core/constant/enum_status.dart';
import 'package:threadfon/core/constant/enum_units.dart';
import 'package:threadfon/core/models/user_selection.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/features/info/models/info_model.dart';
import 'package:threadfon/features/info/repositories/info_repository.dart';

part 'info_bloc.freezed.dart';
part 'info_bloc.g.dart';
part 'info_state.dart';

final _logger = LogService('info_bloc');

class InfoBloc extends Cubit<InfoState> {
  InfoBloc({
    required InfoRepository repository,
    required LocalStorage localStorage,
    required LanguageBloc languageBloc,
    required ThemeBloc themeBloc,
  })  : _repository = repository,
        _localStorage = localStorage,
        _languageBloc = languageBloc,
        _themeBloc = themeBloc,
        super(const InfoState());

  final InfoRepository _repository;
  final ThemeBloc _themeBloc;
  final LocalStorage _localStorage;
  final LanguageBloc _languageBloc;

  Future<void> load() async {
    emit(state.copyWith(enumPageStatus: EnumPageStatus.loading));
    final userSelection = await _localStorage.getUserSelection();

    try {
      final model = await _repository.fetchInfo(
        diameter: userSelection.diameter!,
        pitch: userSelection.pitch!,
        threadType: userSelection.threadType!.name,
        tolerance: userSelection.tolerance!,
        language: _languageBloc.state.enumLang.name,
        units: userSelection.units.name,
        precision: userSelection.precision,
      );

      emit(state.copyWith(
        enumPageStatus: EnumPageStatus.success,
        model: model,
        units: userSelection.units,
        precision: userSelection.precision,
      ));

      // Start fetching SVG data in the background
      _fetchSvgData(userSelection);
    } catch (e, s) {
      _logger.e('Error loading info', error: e, stackTrace: s);
      _setErrorState();
    }
  }

// New method to fetch SVG data
  Future<void> _fetchSvgData(UserSelection userSelection) async {
    try {
      final svgData = await _repository.fetchSvgData(
        diameter: userSelection.diameter!,
        pitch: userSelection.pitch!,
        threadType: userSelection.threadType!.name,
        tolerance: userSelection.tolerance!,
        theme: _themeBloc.state.themeMode.name,
        units: userSelection.units.name,
        precision: userSelection.precision,
        showDimensions: true, // Fetch SVG with dimensions
      );

      final svgDataNoDimensions = await _repository.fetchSvgData(
        diameter: userSelection.diameter!,
        pitch: userSelection.pitch!,
        threadType: userSelection.threadType!.name,
        tolerance: userSelection.tolerance!,
        theme: _themeBloc.state.themeMode.name,
        units: userSelection.units.name,
        precision: userSelection.precision,
        showDimensions: false, // Fetch SVG without dimensions
      );

      // Update the state with SVG data
      emit(state.copyWith(
        svgData: svgData,
        svgDataNoDimensions: svgDataNoDimensions,
        isSvgDataLoaded: true,
      ));
    } catch (e, s) {
      _logger.e('Error fetching SVG data', error: e, stackTrace: s);
      // Optionally handle SVG fetch errors
    }
  }

  Future<void> preparationNavigation() async {
    emit(
        state.copyWith(enumNavigationStatus: EnumNavigationStatus.preparation));

    try {
      await _localStorage.updateUserSelection(
        (current) => current.copyWith(
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
    await _localStorage.updateUserSelection(
        (current) => current.copyWith(units: units, precision: precision));
    await load();
  }

  void _setErrorState() {
    final currentLang = _languageBloc.state.enumLang;
    final errorMsg = currentLang == EnumLang.en
        ? 'An error occurred while loading info.'
        : 'Произошла ошибка при загрузке информации.';
    emit(state.copyWith(
        enumPageStatus: EnumPageStatus.error,
        errorMsg: errorMsg,
        enumNavigationStatus: EnumNavigationStatus.initial));
  }
}
