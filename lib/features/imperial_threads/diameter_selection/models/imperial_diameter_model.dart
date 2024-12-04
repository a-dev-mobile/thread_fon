import 'package:freezed_annotation/freezed_annotation.dart';

part 'imperial_diameter_model.freezed.dart';
part 'imperial_diameter_model.g.dart';

@freezed
class ImperialDiameterModel with _$ImperialDiameterModel {
  const factory ImperialDiameterModel({
    required int id,
    required String info,
    required double diameter,
  }) = _ImperialDiameterModel;

  factory ImperialDiameterModel.fromJson(Map<String, dynamic> json) =>
      _$ImperialDiameterModelFromJson(json);
}
