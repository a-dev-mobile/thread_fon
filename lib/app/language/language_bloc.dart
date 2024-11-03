import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:threadfon/core/services/local_storage/local_storage.dart';

part 'language_bloc.freezed.dart';
part 'language_bloc.g.dart';
part 'language_state.dart';

class LanguageBloc extends Cubit<LanguageState> {
  LanguageBloc({
    required LocalStorage storage,
    required EnumLang enumLang,
  })  : _storage = storage,
        super(LanguageState(enumLang: enumLang));
  final LocalStorage _storage;

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
