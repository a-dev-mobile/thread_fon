// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'm_thread_tolerance_model.g.dart';
part 'm_thread_tolerance_model.freezed.dart';

@freezed
class MThreadToleranceModel with _$MThreadToleranceModel {
  factory MThreadToleranceModel(
          {@Default('') String id,
          @Default(<String>[]) List<String> listTolerance}) =
      _MThreadToleranceModel;

  factory MThreadToleranceModel.fromJson(Map<String, dynamic> json) =>
      _$MThreadToleranceModelFromJson(json);
}
