part of 'metric_info_bloc.dart';

@freezed
@immutable
class MetricInfoState with _$MetricInfoState {
  const factory MetricInfoState({
    MetricInfoModel? model,
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
    @Default(false) bool isSvgOverlayVisible,
    @Default(false) bool showDimensions,
  }) = _InfoState;

  factory MetricInfoState.fromJson(Map<String, dynamic> json) =>
      _$MetricInfoStateFromJson(json);
}
