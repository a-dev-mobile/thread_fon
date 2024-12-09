import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:threadfon/core/constant/enum_thread%20copy.dart';
import 'package:threadfon/features/thread_type_selection/models/thread_type_model.dart';

part 'imperial_info_model.freezed.dart';
part 'imperial_info_model.g.dart';

@freezed
class ImperialInfoModel with _$ImperialInfoModel {
  const factory ImperialInfoModel({
    required int id,

    @JsonKey(name: 'fractional_diameter') required String fractionalDiameter,
    @JsonKey(name: 'decimal_diameter') required num decimalDiameter,
    required String description,
    required num tpi,
    required num pitch,
    @JsonKey(name: 'series_designation') required String seriesDesignation,
    @JsonKey(name: 'type') required EnumThreadMaleFemale threadType,
    @JsonKey(name: 'class') required String threadClass, // Изменено на threadClass
    required num allowance,
    @JsonKey(name: 'major_diam_max') num? majorDiamMax,
    @JsonKey(name: 'major_diam_min') num? majorDiamMin,
    @JsonKey(name: 'pitch_diameter_max') num? pitchDiameterMax,
    @JsonKey(name: 'pitch_diameter_min') num? pitchDiameterMin,
    @JsonKey(name: 'pitch_diameter_tolerance') num? pitchDiameterTolerance,
    @JsonKey(name: 'unr_minor_diameter_max') num? unrMinorDiameterMax,
    @JsonKey(name: 'd_max') num? dMax,
    @JsonKey(name: 'd_min') num? dMin,
    @JsonKey(name: 'd2_max') num? d2Max,
    @JsonKey(name: 'd2_min') num? d2Min,
    @JsonKey(name: 'd3_max') num? d3Max,
    @JsonKey(name: 'd3_min') num? d3Min,
    @JsonKey(name: 'r_max') num? rMax,
    @JsonKey(name: 'r_min') num? rMin,
    @JsonKey(name: 'd_maj_max') num? dMajMax,
    @JsonKey(name: 'd_maj_min') num? dMajMin,
    @JsonKey(name: 'd2_maj_max') num? d2MajMax,
    @JsonKey(name: 'd2_maj_min') num? d2MajMin,
    @JsonKey(name: 'd1_max') num? d1Max,
    @JsonKey(name: 'd1_min') num? d1Min,
    @JsonKey(name: 't_d1') num? tD1,
    @JsonKey(name: 'minor_diameter_max') num? minorDiameterMax,
    @JsonKey(name: 'minor_diameter_min') num? minorDiameterMin,
    @JsonKey(name: 'minor_diam_max_d3') num? minorDiamMaxD3,
    @JsonKey(name: 'minor_diam_min_d3') num? minorDiamMinD3,
    @JsonKey(name: 'minor_diam_avg_d3') num? minorDiamAvgD3,
    @JsonKey(name: 'three_h_div_8') num? threeHDiv8,
    @JsonKey(name: 'five_h_div_8') num? fiveHDiv8,
    @JsonKey(name: 'h_div_4') num? hDiv4,
    @JsonKey(name: 'h_div_8') num? hDiv8,
    @JsonKey(name: 'pitch_div_2') num? pitchDiv2,
    @JsonKey(name: 'pitch_div_4') num? pitchDiv4,
    @JsonKey(name: 'pitch_div_8') num? pitchDiv8,
    @JsonKey(name: 'thread_depth') num? threadDepth,
    @JsonKey(name: 'pitch_diam_d2') num? pitchDiamD2,
    @JsonKey(name: 'pitch_diam_min') num? pitchDiamMin,
    @JsonKey(name: 'pitch_diam_avg') num? pitchDiamAvg,
    @JsonKey(name: 'pitch_diam_max') num? pitchDiamMax,
    @JsonKey(name: 'minor_diam_d1') num? minorDiamD1,
    @JsonKey(name: 'minor_diam_d3') num? minorDiamD3,
    required num h,
    @JsonKey(name: 'd_es') num? dEs,
    @JsonKey(name: 'd_ei') num? dEi,
    @JsonKey(name: 'd1_es') num? d1Es,
    @JsonKey(name: 'd1_ei') num? d1Ei,
    @JsonKey(name: 'd2_es') num? d2Es,
    @JsonKey(name: 'd2_ei') num? d2Ei,
    @JsonKey(name: 'd3_es') num? d3Es,
    @JsonKey(name: 'd3_ei') num? d3Ei,
  }) = _ImperialInfoModel;

  factory ImperialInfoModel.fromJson(Map<String, dynamic> json) =>
      _$ImperialInfoModelFromJson(json);
}
