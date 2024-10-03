part of 'thread_type_controller.dart';

@freezed
class ThreadTypeState with _$ThreadTypeState {
  const factory ThreadTypeState({
    @Default([]) List<ThreadTypeModel> threadTypes,
    @Default(EnumScreenStatus.initial) EnumScreenStatus status,
    String? error,
  }) = _ThreadTypeState;

  factory ThreadTypeState.fromJson(Map<String, dynamic> json) => _$ThreadTypeStateFromJson(json);
}
