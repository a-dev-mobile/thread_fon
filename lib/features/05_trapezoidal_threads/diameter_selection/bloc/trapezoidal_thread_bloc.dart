// lib/features/trapezoidal_threads/bloc/trapezoidal_thread_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:threadfon/app/language/language_bloc.dart';
import 'package:threadfon/core/constant/enum_lang.dart';
import 'package:threadfon/core/constant/enum_navigation_status.dart';
import 'package:threadfon/core/constant/enum_status.dart';
import 'package:threadfon/core/mixins/bloc_ignore_emit_after_closed.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/features/05_trapezoidal_threads/core/models/trapezoidal_user_selection.dart';

import '../models/trapezoidal_thread_model.dart';
import '../repositories/trapezoidal_thread_repository.dart';

part 'trapezoidal_thread_state.dart';
part 'trapezoidal_thread_bloc.freezed.dart';
part 'trapezoidal_thread_bloc.g.dart';

final LogService _logger = LogService('trapezoidal_thread_bloc');

class TrapezoidalThreadBloc extends Cubit<TrapezoidalThreadState>
    with BlocIgnoreEmitAfterClosed<TrapezoidalThreadState> {
  TrapezoidalThreadBloc({
    required TrapezoidalThreadRepository repository,
    required LocalStorage localStorage,
    required LanguageBloc languageBloc,  // Added LanguageBloc
  })  : _repository = repository,
        _localStorage = localStorage,
        _languageBloc = languageBloc,  // Added field
        super(const TrapezoidalThreadState());

  final TrapezoidalThreadRepository _repository;
  final LocalStorage _localStorage;
  final LanguageBloc _languageBloc;  // Added field

  Future<void> loadThreads() async {
    emit(state.copyWith(enumPageStatus: EnumStatus.loading));
    try {
      final List<TrapezoidalThreadModel> threads = await _repository.fetchThreads();
      final double scrollPosition = await _localStorage.getTrapezoidalScrollPosition();

      emit(state.copyWith(
        enumPageStatus: EnumStatus.success,
        threads: threads,
        scrollPosition: scrollPosition,
      ));
    } catch (e, s) {
      _logger.e('Error loading trapezoidal threads', error: e, stackTrace: s);
      _setErrorState();
    }
  }

  Future<void> preparationNavigation(
      TrapezoidalThreadModel model, double scrollPosition) async {
    await _localStorage.setTrapezoidalScrollPosition(scrollPosition);
    try {
      await _localStorage.updateTrapezoidalUserSelection(
        (TrapezoidalUserSelection current) => current.copyWith(
          diameter: model.diameter,
          pitch: model.pitch,

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
        ? 'An error occurred while loading thread data.'
        : 'Произошла ошибка при загрузке данных резьбы.';
    emit(state.copyWith(
        enumPageStatus: EnumStatus.error,
        errorMsg: errorMsg,
        enumNavigationStatus: EnumNavigationStatus.initial));
  }
}
