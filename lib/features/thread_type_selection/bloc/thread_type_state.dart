part of 'thread_type_bloc.dart';

@freezed
class ThreadTypeState with _$ThreadTypeState {
  const factory ThreadTypeState({
    @Default([]) List<ThreadTypeModel> threadTypes,
    @Default(EnumStatus.init) EnumStatus status,
    String? errorMsg, // Поле для сообщения об ошибке
  }) = _ThreadTypeState;

  factory ThreadTypeState.fromJson(Map<String, dynamic> json) =>
      _$ThreadTypeStateFromJson(json);
}
