part of 'metric_diameter_bloc.dart';

@freezed
@immutable
class MetricDiameterState with _$MetricDiameterState {
  const factory MetricDiameterState({
    @Default(<MetricDiameterModel>[]) List<MetricDiameterModel> diameters,
    @Default(EnumStatus.loading) EnumStatus enumPageStatus,
    @Default(EnumNavigationStatus.initial)
    EnumNavigationStatus enumNavigationStatus,
    String? errorMsg,
    @Default(0.0) double scrollPosition,
  }) = _MetricDiameterState;

  factory MetricDiameterState.fromJson(Map<String, dynamic> json) =>
      _$MetricDiameterStateFromJson(json);
}
