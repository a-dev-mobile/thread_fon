part of 'settings_bloc.dart';

@freezed
@immutable
sealed class SettingsState with _$SettingsState {
  const factory SettingsState({
    @Default(EnumStatus.loading) EnumStatus enumPageStatus,
    String? errorMsg,
    @Default(EnumThreads.metric) EnumThreads enumThreads,
  }) = _SettingsState;

  factory SettingsState.fromJson(Map<String, dynamic> json) =>
      _$SettingsStateFromJson(json);
}
