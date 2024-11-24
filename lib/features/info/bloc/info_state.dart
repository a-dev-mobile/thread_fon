part of 'info_bloc.dart';

@freezed
class InfoState with _$InfoState {
  const factory InfoState({
    InfoModel? model,
    String? svgData,
    String? svgDataNoDimensions,
    @Default(EnumStatus.loading) EnumStatus svgRequestStatus,
    @Default(EnumStatus.loading) EnumStatus enumPageStatus,
    @Default(EnumNavigationStatus.initial)
    EnumNavigationStatus enumNavigationStatus,
    String? errorMsg,
    String? svgErrorMsg,
    @Default(EnumUnits.mm) EnumUnits units,
    @Default(3) int precision,
  }) = _InfoState;

  factory InfoState.fromJson(Map<String, dynamic> json) =>
      _$InfoStateFromJson(json);
}
