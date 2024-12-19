// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:threadfon/core/constant/enum_thread%20copy.dart';

part 'imperial_info_model.freezed.dart';
part 'imperial_info_model.g.dart';

@freezed
class ImperialInfoModel with _$ImperialInfoModel {
  const factory ImperialInfoModel({
    required int id,
    required String fractional_diameter,
    required num decimal_diameter,
    required String description,
    required String designation1,
    required String designation2,
    required num tpi,
    required num pitch,
    required String series_designation,
    required String series,
    @JsonKey(name: 'type') required EnumThreadMaleFemale type_,
    required num t_d2,
    required num t_d,
    required num allowance,
    num? major_diam_max,
    num? major_diam_es,
    required num major_diameter_basic,
    required num major_diameter_avg,
    num? major_diam_ei,
    num? major_diam_min,
    num? pitch_diameter_max,
    num? pitch_diameter_es,
    required num pitch_diameter_basic,
    num? pitch_diameter_ei,
    num? pitch_diameter_min,
    required num pitch_diameter_avg,
    num? minor_diameter_max,
    num? minor_diam_es,
    required num minor_diameter_basic,
    num? minor_diam_ei,
    num? minor_diameter_min,
    required num minor_diameter_avg,
    num? unr_minor_diameter_max,
    required num h,
    required String units,
    required num pitch_diameter_tolerance,
    num? major_diam_min2,
  }) = _ImperialInfoModel;

  factory ImperialInfoModel.fromJson(Map<String, dynamic> json) =>
      _$ImperialInfoModelFromJson(json);
}
