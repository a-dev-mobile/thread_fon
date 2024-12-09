import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:threadfon/core/constant/enum_thread%20copy.dart';
import 'package:threadfon/core/constant/enum_thread.dart';
import 'package:threadfon/core/constant/enum_units.dart';


import 'package:threadfon/features/thread_type_selection/models/thread_type_model.dart';

part 'imperial_user_selection.freezed.dart';
part 'imperial_user_selection.g.dart';

@freezed
class ImperialUserSelection with _$ImperialUserSelection {
  const factory ImperialUserSelection({
    EnumThreadMaleFemale? threadType,
    double? diameter,
    int? id,
    double? pitch,

    @Default(EnumThreads.imperial) EnumThreads enumThreads,
    String? tolerance,
    String? fullName,
    @Default(EnumUnits.inch) EnumUnits units,
    @Default(3) int precision,
  }) = _ImperialUserSelection;

  factory ImperialUserSelection.fromJson(Map<String, dynamic> json) => _$ImperialUserSelectionFromJson(json);
}
