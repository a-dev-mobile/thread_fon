import 'package:freezed_annotation/freezed_annotation.dart';

part 'metric_diameter_model.freezed.dart';
part 'metric_diameter_model.g.dart';

@freezed
@immutable
sealed class MetricDiameterModel with _$MetricDiameterModel {
  const factory MetricDiameterModel({
    required int id,
    required String info,
    required double diameter,
  }) = _MetricDiameterModel;

  factory MetricDiameterModel.fromJson(Map<String, dynamic> json) =>
      _$MetricDiameterModelFromJson(json);
}
