import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';

part 'theme_bloc.freezed.dart';
part 'theme_bloc.g.dart';
part 'theme_state.dart';

class ThemeBloc extends Cubit<ThemeState> {
  ThemeBloc({
    required LocalStorage storage,
  })  : _storage = storage,
        super(ThemeState());

  final LocalStorage _storage;
  Future<void> load() async {
    var theme = await _storage.getThemeState();
    emit(theme);
  }

  // Метод для установки конкретной темы и сохранения в SharedPreferences
  Future<void> setTheme(ThemeMode mode) async {
    final newState = state.copyWith(themeMode: mode);
    emit(newState);
    _storage.setThemeState(newState);
  }

  // Метод для переключения темы и сохранения в SharedPreferences
  Future<void> toggle() async {
    if (state.themeMode == ThemeMode.dark) {
      setTheme(ThemeMode.light);
    } else {
      setTheme(ThemeMode.dark);
    }
  }
}
