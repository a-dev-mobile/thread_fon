import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:threadfon/core/constant/enum_units.dart';

part 'imperial_user_selection.freezed.dart';
part 'imperial_user_selection.g.dart';

@freezed
class ImperialUserSelection with _$ImperialUserSelection {
  const factory ImperialUserSelection({
    String? diameter,
    String? tolerance,
    String? tpi,
    int? id,
    String? fullName,
    @Default(EnumUnits.inch) EnumUnits units,
    @Default(3) int precision,
  }) = _ImperialUserSelection;

  factory ImperialUserSelection.fromJson(Map<String, dynamic> json) =>
      _$ImperialUserSelectionFromJson(json);
}
