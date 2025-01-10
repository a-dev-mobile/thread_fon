// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'trapezoidal_info_model.freezed.dart';
part 'trapezoidal_info_model.g.dart';

@freezed
@immutable
class DiameterData with _$DiameterData {
  const factory DiameterData({
    required num max,
    required num es,
    required num basic,
    required num avg,
    required num ei,
    required num min,
  }) = _DiameterData;

  factory DiameterData.fromJson(Map<String, dynamic> json) =>
      _$DiameterDataFromJson(json);
}

@freezed
@immutable
class AdditionalInfo with _$AdditionalInfo {
  const factory AdditionalInfo({
    required String name,
    required String value,
    required String description,
  }) = _AdditionalInfo;

  factory AdditionalInfo.fromJson(Map<String, dynamic> json) =>
      _$AdditionalInfoFromJson(json);
}

@freezed
@immutable
class TrapezoidalInfoModel with _$TrapezoidalInfoModel {
  const factory TrapezoidalInfoModel({
    required int id,
    required String description,
    required String designation,
    required num diameter,
    required num pitch,
    required num d1,
    required num d2,
    required num d3,
    required num d4,
    required String tolerance,
    required String type,
    required String units,
    required DiameterData major_diameter,
    required DiameterData pitch_diameter,
    required DiameterData minor_diameter,
    @Default(<AdditionalInfo>[]) List<AdditionalInfo> additional_info,
  }) = _TrapezoidalInfoModel;

  factory TrapezoidalInfoModel.fromJson(Map<String, dynamic> json) =>
      _$TrapezoidalInfoModelFromJson(json);
}
