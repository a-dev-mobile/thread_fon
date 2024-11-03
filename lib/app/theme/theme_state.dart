part of 'theme_bloc.dart';


@freezed
sealed class ThemeState with _$ThemeState {
  // const DebugState._();

  const factory ThemeState({
    @Default(ThemeMode.dark) ThemeMode themeMode,
    
  }) = _ThemeState;

  factory ThemeState.fromJson(Map<String, Object?> json) =>
      _$ThemeStateFromJson(json);
}
