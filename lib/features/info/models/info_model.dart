import 'package:freezed_annotation/freezed_annotation.dart';

part 'info_model.freezed.dart';
part 'info_model.g.dart';

@freezed
class InfoModel with _$InfoModel {
  const factory InfoModel({
    required int id,
    required double diameter,
    required double pitch,
    required String tolerance,
    required String designation,
    required String description,
      @JsonKey(name: 'type_pitch_description')   required String typePitchDescription,
    @JsonKey(name: 'type_pitch') required int typePitch,
    @JsonKey(name: 'range_main') int? rangeMain,
    @JsonKey(name: 'range_sub') double? rangeSub,
    @JsonKey(name: 'thread_depth') required double threadDepth,
    @JsonKey(name: 'major_diam_min') required double majorDiamMin,
    @JsonKey(name: 'major_diam_avg') required double majorDiamAvg,
    @JsonKey(name: 'major_diam_max') required double majorDiamMax,
    @JsonKey(name: 'pitch_diam_d2') required double pitchDiamD2,
    @JsonKey(name: 'pitch_diam_min') required double pitchDiamMin,
    @JsonKey(name: 'pitch_diam_avg') required double pitchDiamAvg,
    @JsonKey(name: 'pitch_diam_max') required double pitchDiamMax,
    @JsonKey(name: 'minor_diam_min') required double minorDiamMin,
    @JsonKey(name: 'minor_diam_avg') required double minorDiamAvg,
    @JsonKey(name: 'minor_diam_max') required double minorDiamMax,
    @JsonKey(name: 'minor_diam_d1') required double minorDiamD1,
    @JsonKey(name: 'minor_diam_d3') required double minorDiamD3,
    required double h,
    @JsonKey(name: 'd_es') double? dEs,
    @JsonKey(name: 'd_ei') double? dEi,
    @JsonKey(name: 'd1_es') double? d1Es,
    @JsonKey(name: 'd1_ei') double? d1Ei,
    @JsonKey(name: 'd2_es') double? d2Es,
    @JsonKey(name: 'd2_ei') double? d2Ei,
  }) = _InfoModel;

  factory InfoModel.fromJson(Map<String, dynamic> json) =>
      _$InfoModelFromJson(json);
}
