import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:threadfon/core/constant/enum_thread%20copy.dart';
import 'package:threadfon/features/thread_type_selection/models/thread_type_model.dart';

part 'info_model.freezed.dart';
part 'info_model.g.dart';

@freezed
class InfoModel with _$InfoModel {
  const factory InfoModel({
    required int id,
    required num diameter,
    required num pitch,
    required String tolerance,
    required String designation,
    required String description,
    @JsonKey(name: 'thread_type') required EnumThreadMaleFemale threadType,
    @JsonKey(name: 'type_pitch_description') required String typePitchDescription,
    @JsonKey(name: 'type_pitch') required int typePitch,
    @JsonKey(name: 'range_main') int? rangeMain,
    @JsonKey(name: 'range_sub') num? rangeSub,
    @JsonKey(name: 'hole_diameter') num? holeDiameter,
    @JsonKey(name: 'cmax') num? cMax,
    @JsonKey(name: 'cmin') num? cMin,
    @JsonKey(name: 'rmax') num? rMax,
    @JsonKey(name: 'rmin') num? rMin,
    @JsonKey(name: 'minor_diam_max_d3') num? minorDiamMaxD3,
    @JsonKey(name: 'minor_diam_min_d3') num? minorDiamMinD3,
    @JsonKey(name: 'minor_diam_avg_d3') num? minorDiamAvgD3,
    @JsonKey(name: 'three_h_div_8') required num threeHDiv8,
    @JsonKey(name: 'five_h_div_8') required num fiveHDiv8,
    @JsonKey(name: 'h_div_4') required num hDiv4,
    @JsonKey(name: 'h_div_8') required num hDiv8,
    @JsonKey(name: 'pitch_div_2') required num pitchDiv2,
    @JsonKey(name: 'pitch_div_4') required num pitchDiv4,
    @JsonKey(name: 'pitch_div_8') required num pitchDiv8,
    @JsonKey(name: 'thread_depth') required num threadDepth,
    @JsonKey(name: 'major_diam_min') required num majorDiamMin,
    @JsonKey(name: 'major_diam_avg') required num majorDiamAvg,
    @JsonKey(name: 'major_diam_max') required num majorDiamMax,
    @JsonKey(name: 'pitch_diam_d2') required num pitchDiamD2,
    @JsonKey(name: 'pitch_diam_min') required num pitchDiamMin,
    @JsonKey(name: 'pitch_diam_avg') required num pitchDiamAvg,
    @JsonKey(name: 'pitch_diam_max') required num pitchDiamMax,
    @JsonKey(name: 'minor_diam_min') required num minorDiamMin,
    @JsonKey(name: 'minor_diam_avg') required num minorDiamAvg,
    @JsonKey(name: 'minor_diam_max') required num minorDiamMax,
    @JsonKey(name: 'minor_diam_d1') required num minorDiamD1,
    @JsonKey(name: 'minor_diam_d3') required num minorDiamD3,
    required num h,
    @JsonKey(name: 'd_es') num? dEs,
    @JsonKey(name: 'd_ei') num? dEi,
    @JsonKey(name: 'd1_es') num? d1Es,
    @JsonKey(name: 'd1_ei') num? d1Ei,
    @JsonKey(name: 'd2_es') num? d2Es,
    @JsonKey(name: 'd2_ei') num? d2Ei,
    @JsonKey(name: 'd3_es') num? d3Es,
    @JsonKey(name: 'd3_ei') num? d3Ei,
  }) = _InfoModel;

  factory InfoModel.fromJson(Map<String, dynamic> json) => _$InfoModelFromJson(json);
}
