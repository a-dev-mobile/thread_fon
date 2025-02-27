import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:threadfon/core/mixins/bloc_ignore_emit_after_closed.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';

part 'theme_bloc.freezed.dart';
part 'theme_bloc.g.dart';
part 'theme_state.dart';

class ThemeBloc extends Cubit<ThemeState> with BlocIgnoreEmitAfterClosed {
  ThemeBloc({
    required LocalStorage storage,
    required ThemeMode themeMode,
  })  : _storage = storage,
        super(ThemeState(themeMode: themeMode));

  final LocalStorage _storage;

  /// Устанавливает новую тему и сохраняет её в хранилище
  void setTheme(ThemeMode mode) {
    emit(state.copyWith(themeMode: mode));
    _storage.setThemeState(state);
  }

  /// Переключает между светлой и тёмной темой
  void toggle() {
    setTheme(
        state.themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);
  }
}
