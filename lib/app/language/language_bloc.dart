import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:threadfon/core/constant/enum_lang.dart';
import 'package:threadfon/core/mixins/bloc_ignore_emit_after_closed.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';

part 'language_bloc.freezed.dart';
part 'language_bloc.g.dart';
part 'language_state.dart';

class LanguageBloc extends Cubit<LanguageState> with BlocIgnoreEmitAfterClosed {
  LanguageBloc({required LocalStorage storage, required EnumLang enumLang})
    : _storage = storage,
      super(LanguageState(enumLang: enumLang));

  final LocalStorage _storage;

  /// Устанавливает новый язык и сохраняет его в хранилище
  Future<void> setLanguage(EnumLang value) async {
    emit(state.copyWith(enumLang: value));
    await _storage.setLanguageState(state);
  }

  /// Переключает язык между английским и русским
  Future<void> toggle() async {
    final EnumLang newLang = state.enumLang == EnumLang.en
        ? EnumLang.ru
        : EnumLang.en;
    await setLanguage(newLang);
  }
}
