// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'm_thread_pitch_model.g.dart';
part 'm_thread_pitch_model.freezed.dart';

@freezed
class MThreadPitchModel with _$MThreadPitchModel {
  factory MThreadPitchModel({
    @Default(false) bool isCoarse,
    @Default(false) bool isFine,
    @Default(false) bool isSuperFine,
    @Default('') String pitchCoarse,
    @Default(<String>[]) List<String> pitchsFine,
    @Default(<String>[]) List<String> pitchsSuperFine,
  }) = _MThreadPitchModel;

  factory MThreadPitchModel.fromJson(Map<String, dynamic> json) =>
      _$MThreadPitchModelFromJson(json);
}
