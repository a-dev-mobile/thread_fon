// ignore_for_file: non_constant_identifier_names

// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'm_thread_model.freezed.dart';
part 'm_thread_model.g.dart';

@freezed
class MThreadModel with _$MThreadModel {
  const factory MThreadModel({
    @Default('') String id,
    @Default('') String diam,
    @Default('') String tolerance,
    @Default(false) bool isCoarsePitch,
    @Default(false) bool isFinePitch,
    @Default(false) bool isSuperFinePitch,
    @Default(false) bool isMale,
    @Default(0.0) double es_d,
    @Default(0.0) double ei_d,
    @Default(0.0) double es_d1,
    @Default(0.0) double ei_d1,
    @Default(0.0) double es_d2,
    @Default(0.0) double ei_d2,
    @Default('') String pitch,
  }) = _MThreadModel;

  factory MThreadModel.fromJson(Map<String, dynamic> json) =>
      _$MThreadModelFromJson(json);
}
