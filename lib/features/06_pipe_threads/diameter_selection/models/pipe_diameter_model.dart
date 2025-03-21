import 'package:freezed_annotation/freezed_annotation.dart';

part 'pipe_diameter_model.freezed.dart';
part 'pipe_diameter_model.g.dart';

@freezed
@immutable
sealed class PipeDiameterModel with _$PipeDiameterModel {
  const factory PipeDiameterModel({
    required List<PipeDiameterItem> female,
    required List<PipeDiameterItem> male,
  }) = _PipeDiameterModel;

  factory PipeDiameterModel.fromJson(Map<String, dynamic> json) =>
      _$PipeDiameterModelFromJson(json);
}

@freezed
@immutable
sealed class PipeDiameterItem with _$PipeDiameterItem {
  const factory PipeDiameterItem({
    required int id,
    required String fractional,
    required String decimal,
    String? tolerance, // Optional for female items
  }) = _PipeDiameterItem;

  factory PipeDiameterItem.fromJson(Map<String, dynamic> json) =>
      _$PipeDiameterItemFromJson(json);
}
