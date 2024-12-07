import 'package:freezed_annotation/freezed_annotation.dart';

part 'imperial_tolerance_model.freezed.dart';
part 'imperial_tolerance_model.g.dart';

@freezed
class ImperialToleranceModel with _$ImperialToleranceModel {
  const factory ImperialToleranceModel({
    required List<ImperialToleranceItem> female,
    required List<ImperialToleranceItem> male,
  }) = _ImperialToleranceModel;

  factory ImperialToleranceModel.fromJson(Map<String, dynamic> json) => _$ImperialToleranceModelFromJson(json);
}

@freezed
class ImperialToleranceItem with _$ImperialToleranceItem {
  const factory ImperialToleranceItem({
    required int id,
    required String tolerance,
    required ImperialToleranceFormatted formatted,
  }) = _ImperialToleranceItem;

  factory ImperialToleranceItem.fromJson(Map<String, dynamic> json) => _$ImperialToleranceItemFromJson(json);
}

@freezed
class ImperialToleranceFormatted with _$ImperialToleranceFormatted {
  const factory ImperialToleranceFormatted({
    required String fractional,
    required String decimal,
  }) = _ImperialToleranceFormatted;

  factory ImperialToleranceFormatted.fromJson(Map<String, dynamic> json) => _$ImperialToleranceFormattedFromJson(json);
}
