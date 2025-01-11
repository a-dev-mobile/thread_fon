// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'trapezoidal_info_model.freezed.dart';
part 'trapezoidal_info_model.g.dart';

@freezed
@immutable
class DiameterInfo with _$DiameterInfo {
  const factory DiameterInfo({
    required String name,
    required String max,
    required String es,
    required String basic,
    required String avg,
    required String ei,
    required String min,
  }) = _DiameterInfo;

  factory DiameterInfo.fromJson(Map<String, dynamic> json) =>
      _$DiameterInfoFromJson(json);
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
    required String description,
    required String designation,
    required String diameter,
    required String pitch,
    required String tolerance,
    required String type,
    required String units,
    required List<DiameterInfo> diameter_info,
    required List<AdditionalInfo> additional_info,
  }) = _TrapezoidalInfoModel;

  factory TrapezoidalInfoModel.fromJson(Map<String, dynamic> json) =>
      _$TrapezoidalInfoModelFromJson(json);
}
