part of 'theme_bloc.dart';

@freezed
@immutable
sealed class ThemeState with _$ThemeState {
  const factory ThemeState({required ThemeMode themeMode}) = _ThemeState;

  factory ThemeState.fromJson(Map<String, Object?> json) =>
      _$ThemeStateFromJson(json);
}
