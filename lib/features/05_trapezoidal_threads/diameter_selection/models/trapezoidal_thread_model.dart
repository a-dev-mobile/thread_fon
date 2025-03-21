import 'package:freezed_annotation/freezed_annotation.dart';

part 'trapezoidal_thread_model.g.dart';
part 'trapezoidal_thread_model.freezed.dart';

@freezed
@immutable
sealed class TrapezoidalThreadModel with _$TrapezoidalThreadModel {
  const factory TrapezoidalThreadModel({
    required String diameter,
    required String pitch,
    required String designation,
  }) = _TrapezoidalThreadModel;

  factory TrapezoidalThreadModel.fromJson(Map<String, dynamic> json) =>
      _$TrapezoidalThreadModelFromJson(json);
}
