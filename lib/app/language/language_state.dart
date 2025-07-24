part of 'language_bloc.dart';

@freezed
@immutable
sealed class LanguageState with _$LanguageState {
  const factory LanguageState({required EnumLang enumLang}) = _LanguageState;

  factory LanguageState.fromJson(Map<String, Object?> json) =>
      _$LanguageStateFromJson(json);
}
