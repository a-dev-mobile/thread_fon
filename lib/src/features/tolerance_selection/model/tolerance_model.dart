import 'package:freezed_annotation/freezed_annotation.dart';

part 'tolerance_model.freezed.dart';
part 'tolerance_model.g.dart';

@freezed
class ToleranceModel with _$ToleranceModel {
  const factory ToleranceModel({
    required int id,
    required double diameter,
    required double pitch,
    @JsonKey(name: 'type_pitch') required int typePitch,
    @JsonKey(name: 'range_main') double? rangeMain,
    @JsonKey(name: 'range_sub') double? rangeSub,
  }) = _ToleranceModel;

  factory ToleranceModel.fromJson(Map<String, dynamic> json) => _$ToleranceModelFromJson(json);
}
