part of 'thread_type_bloc.dart';

@freezed
@immutable
class ThreadTypeState with _$ThreadTypeState {
  const factory ThreadTypeState({
    @Default(<ThreadTypeModel>[]) List<ThreadTypeModel> threadTypes,
    @Default(EnumStatus.loading) EnumStatus enumPageStatus,
    @Default(EnumNavigationStatus.initial)
    EnumNavigationStatus enumNavigationStatus,
    @Default(MetricDiameterScreen.name) String nextNameScreen,
    @Default(MetricDiameterScreen.name) String subtitle,
    @Default(CoreUserSelection()) CoreUserSelection coreUserSelection,
    String? errorMsg,
  }) = _ThreadTypeState;

  factory ThreadTypeState.fromJson(Map<String, dynamic> json) =>
      _$ThreadTypeStateFromJson(json);
}
