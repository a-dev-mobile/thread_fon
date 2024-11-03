part of 'language_bloc.dart';

enum EnumLang {
  ru,
  en,

}
@freezed
sealed class LanguageState with _$LanguageState {
  // const DebugState._();

  const factory LanguageState({
    EnumLang? enumLang,
    
  }) = _LanguageState;

  factory LanguageState.fromJson(Map<String, Object?> json) =>
      _$LanguageStateFromJson(json);
}
