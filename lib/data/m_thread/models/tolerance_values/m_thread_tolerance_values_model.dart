// ignore_for_file: non_constant_identifier_names

// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'm_thread_tolerance_values_model.g.dart';
part 'm_thread_tolerance_values_model.freezed.dart';

@freezed
class MThreadToleranceValuesModel with _$MThreadToleranceValuesModel {
  factory MThreadToleranceValuesModel({
    @Default(0) double es_d,
    @Default(0) double ei_d,
    @Default(0) double es_d1,
    @Default(0) double ei_d1,
    @Default(0) double es_d2,
    @Default(0) double ei_d2,
  }) = _MThreadToleranceValuesModel;

  factory MThreadToleranceValuesModel.fromJson(Map<String, dynamic> json) =>
      _$MThreadToleranceValuesModelFromJson(json);
}
