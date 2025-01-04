import 'package:freezed_annotation/freezed_annotation.dart';

part 'imperial_diameter_model.freezed.dart';
part 'imperial_diameter_model.g.dart';

@freezed
@immutable
class ImperialDiameterModel with _$ImperialDiameterModel {
  const factory ImperialDiameterModel({
    required int id,
    required Formatted formatted,
    required String series,
    required String tpi,
    required String diameter,
  }) = _ImperialDiameterModel;

  factory ImperialDiameterModel.fromJson(Map<String, dynamic> json) =>
      _$ImperialDiameterModelFromJson(json);
}

@freezed
@immutable
class Formatted with _$Formatted {
  const factory Formatted({
    required String fractional,
    required String decimal,
  }) = _Formatted;

  factory Formatted.fromJson(Map<String, dynamic> json) =>
      _$FormattedFromJson(json);
}
