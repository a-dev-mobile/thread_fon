import 'package:freezed_annotation/freezed_annotation.dart';

part 'trapezoidal_tolerance_model.freezed.dart';
part 'trapezoidal_tolerance_model.g.dart';

@freezed
@immutable
class TrapezoidalToleranceModel with _$TrapezoidalToleranceModel {
  const factory TrapezoidalToleranceModel({
    required List<TrapezoidalToleranceItem> female,
    required List<TrapezoidalToleranceItem> male,
  }) = _TrapezoidalToleranceModel;

  factory TrapezoidalToleranceModel.fromJson(Map<String, dynamic> json) =>
      _$TrapezoidalToleranceModelFromJson(json);
}

@freezed
@immutable
class TrapezoidalToleranceItem with _$TrapezoidalToleranceItem {
  const factory TrapezoidalToleranceItem({
    required String tolerance,
    required String formatted,
  }) = _TrapezoidalToleranceItem;

  factory TrapezoidalToleranceItem.fromJson(Map<String, dynamic> json) =>
      _$TrapezoidalToleranceItemFromJson(json);
}
