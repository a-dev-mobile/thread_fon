import 'package:freezed_annotation/freezed_annotation.dart';

part 'pitch_model.freezed.dart';
part 'pitch_model.g.dart';

enum TypePitch {
  @JsonValue(1)
  large, // Крупный шаг
  @JsonValue(2)
  fine, // Мелкий шаг
  @JsonValue(3)
  superfine, // Супер мелкий шаг
}

enum MetricThreadRange {
  @JsonValue(1)
  first, // 1-й ряд (предпочтительный)
  @JsonValue(2)
  second, // 2-й ряд
  @JsonValue(3)
  third, // 3-й ряд
}

enum InstrumentThreadRange {
  @JsonValue(1)
  first, // 1-й ряд (предпочтительный для приборостроительных резьб)
  @JsonValue(2)
  second, // 2-й ряд
}

@freezed
class PitchModel with _$PitchModel {
  const factory PitchModel({
    required int id,
    required double diameter,
    required double pitch,
    @JsonKey(name: 'type_pitch') required TypePitch typePitch,
    @JsonKey(name: 'range_main') MetricThreadRange? rangeMain,
    @JsonKey(name: 'range_sub') InstrumentThreadRange? rangeSub,
  }) = _PitchModel;

  factory PitchModel.fromJson(Map<String, dynamic> json) => _$PitchModelFromJson(json);
}
