part of 'thread_type_bloc.dart';

@freezed
class ThreadTypeState with _$ThreadTypeState {
  const factory ThreadTypeState({
    @Default([]) List<ThreadTypeModel> threadTypes,
    @Default(EnumStatus.loading) EnumStatus enumPageStatus,
    @Default(EnumNavigationStatus.initial) EnumNavigationStatus enumNavigationStatus,
    @Default(MetricDiameterScreen.name) String nextNameScreen,
    String? errorMsg,
  }) = _ThreadTypeState;

  factory ThreadTypeState.fromJson(Map<String, dynamic> json) => _$ThreadTypeStateFromJson(json);
}
