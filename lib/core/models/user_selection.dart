import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:threadfon/core/constant/enum_units.dart';
import 'package:threadfon/features/metric_threads/pitch_selection/models/pitch_model.dart';
import 'package:threadfon/features/settings/bloc/settings_bloc.dart';
import 'package:threadfon/features/thread_type_selection/models/thread_type_model.dart';

part 'user_selection.freezed.dart';
part 'user_selection.g.dart';

@freezed
class UserSelection with _$UserSelection {
  const factory UserSelection({
    EnumThreadType? threadType,
    double? diameter,
    int? id,
    double? pitch,
    EnumMetricThreadRange? rangeMain,
    EnumInstrumentThreadRange? rangeSub,
    @Default(EnumThreads.metric) EnumThreads enumThreads,
    String? tolerance,
    String? fullName,
    @Default(EnumUnits.mm) EnumUnits units,
    @Default(3) int precision,
  }) = _UserSelection;

  factory UserSelection.fromJson(Map<String, dynamic> json) =>
      _$UserSelectionFromJson(json);
}
