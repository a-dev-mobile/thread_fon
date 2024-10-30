import 'package:freezed_annotation/freezed_annotation.dart';

part 'pitch_model.freezed.dart';
part 'pitch_model.g.dart';

enum EnumPitchDataType {
  @JsonValue(1)
  header,
  @JsonValue(2)
  value,
}

enum EnumMetricThreadRange {
  @JsonValue(1)
  first, // 1-й ряд (предпочтительный)
  @JsonValue(2)
  second, // 2-й ряд
  @JsonValue(3)
  third, // 3-й ряд
}

enum EnumInstrumentThreadRange {
  @JsonValue(1)
  first, // 1-й ряд (предпочтительный для приборостроительных резьб)
  @JsonValue(2)
  second, // 2-й ряд
}

@freezed
class PitchModel with _$PitchModel {
  const factory PitchModel({
    @JsonKey(name: 'type') required EnumPitchDataType enumPitchDataType,
   required String info,
    int? id,
  }) = _PitchModel;

  factory PitchModel.fromJson(Map<String, dynamic> json) =>
      _$PitchModelFromJson(json);
}
