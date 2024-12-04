part of 'metric_diameter_bloc.dart';

@freezed
class MetricDiameterState with _$MetricDiameterState {
  const factory MetricDiameterState({
    @Default([]) List<MetricDiameterModel> diameters,
    @Default(EnumStatus.loading) EnumStatus enumPageStatus,
    @Default(EnumNavigationStatus.initial)
    EnumNavigationStatus enumNavigationStatus,
    String? errorMsg,
    @Default(0.0) double scrollPosition,
  }) = _MetricDiameterState;

  factory MetricDiameterState.fromJson(Map<String, dynamic> json) =>
      _$MetricDiameterStateFromJson(json);
}
