import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:threadfon/core/constant/enums_thread_type.dart';

import 'package:threadfon/features/pitch_selection/models/pitch_model.dart';

part 'user_selection.freezed.dart';
part 'user_selection.g.dart'; // Если вы планируете использовать JSON сериализацию

@freezed
class UserSelection with _$UserSelection {
  const factory UserSelection({
    EnumThreadType? threadType,
    double? diameter,
    int? id,
    double? pitch,
    EnumMetricThreadRange? rangeMain,
    EnumInstrumentThreadRange? rangeSub,
    String? tolerance,
    String? fullName,
  }) = _UserSelection;

  factory UserSelection.fromJson(Map<String, dynamic> json) =>
      _$UserSelectionFromJson(json);
}
