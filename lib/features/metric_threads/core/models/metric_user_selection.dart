import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:threadfon/core/constant/enum_thread.dart';
import 'package:threadfon/core/constant/enum_units.dart';
import 'package:threadfon/features/metric_threads/pitch_selection/models/pitch_model.dart';

import 'package:threadfon/features/thread_type_selection/models/thread_type_model.dart';

part 'metric_user_selection.freezed.dart';
part 'metric_user_selection.g.dart';

@freezed
class MetricUserSelection with _$MetricUserSelection {
  const factory MetricUserSelection({
    double? diameter,
    int? id,
    double? pitch,
    EnumMetricThreadRange? rangeMain,
    EnumInstrumentThreadRange? rangeSub,
    String? tolerance,
    String? fullName,
    @Default(EnumUnits.mm) EnumUnits units,
    @Default(3) int precision,
  }) = _MetricUserSelection;

  factory MetricUserSelection.fromJson(Map<String, dynamic> json) => _$MetricUserSelectionFromJson(json);
}
