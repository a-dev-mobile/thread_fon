part of 'settings_bloc.dart';

enum EnumThreads {
  metric,
  imperialThread,
}

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState({
    @Default(EnumStatus.loading) EnumStatus enumPageStatus,
    String? errorMsg,
    @Default(EnumThreads.metric) EnumThreads enumThreads,
  }) = _SettingsState;

  factory SettingsState.fromJson(Map<String, dynamic> json) =>
      _$SettingsStateFromJson(json);
}
