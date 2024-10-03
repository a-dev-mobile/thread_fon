// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'm_thread_diam_model.g.dart';
part 'm_thread_diam_model.freezed.dart';

@freezed
class MThreadDiamModel with _$MThreadDiamModel {
  factory MThreadDiamModel({required String diam}) = _MThreadDiamModel;

  factory MThreadDiamModel.fromJson(Map<String, dynamic> json) =>
      _$MThreadDiamModelFromJson(json);
}
