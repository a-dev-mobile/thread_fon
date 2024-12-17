import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:threadfon/app/language/language_bloc.dart';
import 'package:threadfon/core/constant/enum_navigation.dart';
import 'package:threadfon/core/constant/enum_status.dart';
import 'package:threadfon/core/constant/enum_thread.dart';
import 'package:threadfon/core/mixins/bloc_ignore_emit_after_closed.dart';
import 'package:threadfon/core/models/core_user_selection.dart';
import 'package:threadfon/core/services/error_reporting/error_reporting_service.dart';

import 'package:threadfon/core/services/local_storage/local_storage.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/features/imperial_threads/diameter_selection/views/imperial_diameter_screen.dart';
import 'package:threadfon/features/metric_threads/diameter_selection/views/metric_diameter_screen.dart';
import 'package:threadfon/features/thread_type_selection/models/thread_type_model.dart';
import 'package:threadfon/features/thread_type_selection/repositories/thread_type_repository.dart';

part 'thread_type_bloc.freezed.dart';
part 'thread_type_bloc.g.dart';
part 'thread_type_state.dart';

final _logger = LogService('thread_type_bloc');

class ThreadTypeBloc extends Cubit<ThreadTypeState>
    with BlocIgnoreEmitAfterClosed {
  ThreadTypeBloc({
    required ThreadTypeRepository repository,
    required LocalStorage localStorage,
    required LanguageBloc languageBloc,
  })  : _localStorage = localStorage,
        _repository = repository,
        _languageBloc = languageBloc,
        super(const ThreadTypeState());

  final LocalStorage _localStorage;
  final LanguageBloc _languageBloc;
  final ThreadTypeRepository _repository;

  Future<void> load() async {
    emit(state.copyWith(enumPageStatus: EnumStatus.loading));
    try {
      final threadTypes = await _repository.fetchThreadTypes();
      final coreUserSelection = await _localStorage.getCoreUserSelection();
      emit(state.copyWith(
          enumPageStatus: EnumStatus.success,
          threadTypes: threadTypes,
          coreUserSelection: coreUserSelection));
    } on Exception catch (e, s) {
      _logger.e('Error loading thread types', error: e, stackTrace: s);
      globalErrorReporting.reportError(
        error: e,
        stackTrace: s,
        customMessage: 'Error loading thread types',
      );
      _setErrorState();
    }
  }

  Future<void> preparationNavigation(ThreadTypeModel selectedThreadType) async {
    try {
      final currentMetricUserSelection =
          await _localStorage.getCoreUserSelection();

      final nextNameScreen = currentMetricUserSelection.enumThreads.isMetric
          ? MetricDiameterScreen.name
          : ImperialDiameterScreen.name;

      await _localStorage.updateCoreUserSelection(
        (current) => current.copyWith(
          threadType: selectedThreadType.enumThreadType,
        ),
      );
      emit(state.copyWith(
          enumNavigationStatus: EnumNavigationStatus.navigation,
          nextNameScreen: nextNameScreen));
      await Future<void>.delayed(const Duration(milliseconds: 100));
      emit(state.copyWith(enumNavigationStatus: EnumNavigationStatus.initial));
    } catch (e, s) {
      _logger.e('Error updating thread type selection',
          error: e, stackTrace: s);

      // Отправляем ошибку в ErrorReportingService
      globalErrorReporting.reportError(
        error: e,
        stackTrace: s,
        customMessage: 'Error loading thread types',
      );

      _setErrorState();
    }
  }

  void _setErrorState() {
    final currentLang = _languageBloc.state.enumLang;
    final errorMsg = currentLang == EnumLang.en
        ? 'An error occurred while loading thread types.'
        : 'Произошла ошибка при загрузке типов резьбы.';
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
