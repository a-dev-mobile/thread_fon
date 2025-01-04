import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:threadfon/app/language/language_bloc.dart';
import 'package:threadfon/core/constant/enum_lang.dart';
import 'package:threadfon/core/constant/enum_status.dart';
import 'package:threadfon/core/constant/enum_threads.dart';
import 'package:threadfon/core/mixins/bloc_ignore_emit_after_closed.dart';
import 'package:threadfon/core/services/error_reporting/error_reporting_service.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';
import 'package:threadfon/core/services/logging/logger.dart';

part 'settings_bloc.freezed.dart';
part 'settings_bloc.g.dart';
part 'settings_state.dart';

final _logger = LogService('settings_bloc');

class SettingsBloc extends Cubit<SettingsState> with BlocIgnoreEmitAfterClosed {
  SettingsBloc({
    required LocalStorage localStorage,
    required LanguageBloc languageBloc,
  })  : _localStorage = localStorage,
        _languageBloc = languageBloc,
        super(const SettingsState());

  final LocalStorage _localStorage;
  final LanguageBloc _languageBloc;

  Future<void> load() async {
    try {
      emit(state.copyWith(enumPageStatus: EnumStatus.loading));
      // final metricUserSelection = await _localStorage.getMetricUserSelection();
      final coreUserSelection = await _localStorage.getCoreUserSelection();
      final enumThreads = coreUserSelection.enumThreads;
      emit(state.copyWith(
        enumPageStatus: EnumStatus.success,
        enumThreads: enumThreads,
      ));
    } catch (e, s) {
      _logger.e('Error loading settings', error: e, stackTrace: s);

      _setErrorState();
    }
  }

  Future<void> setThreadType(EnumThreads enumThreads) async {
    try {
      await _localStorage.updateCoreUserSelection(
        (current) => current.copyWith(enumThreads: enumThreads),
      );
      emit(state.copyWith(enumThreads: enumThreads));
    } catch (e, s) {
      _logger.e('Error updating thread type', error: e, stackTrace: s);

      _setErrorState();
    }
  }

  void _setErrorState() {
    final currentLang = _languageBloc.state.enumLang;
    final errorMsg = currentLang == EnumLang.en
        ? 'An error occurred while loading settings.'
        : 'Произошла ошибка при загрузке настроек.';
    emit(state.copyWith(
      enumPageStatus: EnumStatus.error,
      errorMsg: errorMsg,
    ));
  }
}
