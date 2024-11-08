import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:threadfon/app/language/language_bloc.dart';
import 'package:threadfon/core/constant/enum_navigation.dart';
import 'package:threadfon/core/constant/enum_status.dart';
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
  })  : _repository = repository,
        _localStorage = localStorage,
        _languageBloc = languageBloc,
        super(const InfoState());

  final InfoRepository _repository;
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
      );
      final svgData = await _repository.fetchSvgData(
        diameter: userSelection.diameter!,
        pitch: userSelection.pitch!,
        threadType: userSelection.threadType!.name,
        tolerance: userSelection.tolerance!,
      );
      emit(state.copyWith(
        enumPageStatus: EnumPageStatus.success,
        model: model,
        svgData: svgData,
      ));
    } catch (e, s) {
      _logger.e('Error loading info', error: e, stackTrace: s);
      _setErrorState();
    }
  }

  Future<void> preparationNavigation() async {
    emit(state.copyWith(enumNavigationStatus: EnumNavigationStatus.preparation));

    try {
      await _localStorage.updateUserSelection(
        (current) => current.copyWith(
          id: state.model?.id,
   
        ),
      );
      emit(state.copyWith(enumNavigationStatus: EnumNavigationStatus.navigation));
      await Future<void>.delayed(const Duration(milliseconds: 100));
      emit(state.copyWith(enumNavigationStatus: EnumNavigationStatus.initial));
    } catch (e, s) {
      _logger.e('Error updating selection', error: e, stackTrace: s);
      _setErrorState();
    }
  }

  void _setErrorState() {
    final currentLang = _languageBloc.state.enumLang;
    final errorMsg = currentLang == EnumLang.en
        ? 'An error occurred while loading info.'
        : 'Произошла ошибка при загрузке информации.';
    emit(state.copyWith(enumPageStatus: EnumPageStatus.error, errorMsg: errorMsg));
  }
}
