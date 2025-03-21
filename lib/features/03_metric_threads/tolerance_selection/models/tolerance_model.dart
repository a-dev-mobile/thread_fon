import 'package:freezed_annotation/freezed_annotation.dart';

part 'tolerance_model.freezed.dart';
part 'tolerance_model.g.dart';

@freezed
@immutable
sealed class ToleranceModel with _$ToleranceModel {
  const factory ToleranceModel({
    required String info,
    required String tolerance,
  }) = _ToleranceModel;

  factory ToleranceModel.fromJson(Map<String, dynamic> json) =>
      _$ToleranceModelFromJson(json);
}
