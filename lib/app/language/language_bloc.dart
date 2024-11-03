// language_notifier.dart
import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';

part 'language_bloc.freezed.dart';
part 'language_bloc.g.dart';
part 'language_state.dart';

class LanguageBloc extends Cubit<LanguageState> {
  LanguageBloc({
    required LocalStorage storage,
  })  : _storage = storage,
        super(LanguageState());
  final LocalStorage _storage;

  Future<void> load() async {
    var languageState = await _storage.getLanguageState();

    if (languageState.enumLang == null) {
      final defaultLanguage = EnumLang.values.firstWhere(
        (e) => e.name == PlatformDispatcher.instance.locale.languageCode,
        orElse: () => EnumLang.en,
      );
      emit(state.copyWith(enumLang: defaultLanguage));
    } else {
      emit(languageState);
    }
  }

  Future<void> setLanguage(EnumLang value) async {
    final newState = state.copyWith(enumLang: value);
    emit(newState);
    _storage.setLanguageState(newState);
  }

  Future<void> toggle() async {
    if (state.enumLang == EnumLang.en) {
      setLanguage(EnumLang.ru);
    } else {
      setLanguage(EnumLang.en);
    }
  }
}
