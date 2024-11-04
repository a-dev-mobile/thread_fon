part of 'info_bloc.dart';

@freezed
class InfoState with _$InfoState {
  const factory InfoState({
    InfoModel? model,
    String? svgData,
    @Default(EnumStatus.initial) EnumStatus status,
    String? errorMsg,
  }) = _InfoState;

  factory InfoState.fromJson(Map<String, dynamic> json) =>
      _$InfoStateFromJson(json);
}
