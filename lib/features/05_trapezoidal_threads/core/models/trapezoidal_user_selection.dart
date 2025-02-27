import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:threadfon/core/constant/enum_units.dart';

part 'trapezoidal_user_selection.freezed.dart';
part 'trapezoidal_user_selection.g.dart';

@freezed
@immutable
class TrapezoidalUserSelection with _$TrapezoidalUserSelection {
  const factory TrapezoidalUserSelection({
    String? diameter,
    String? tolerance,
    String? pitch,
    @Default(EnumUnits.mm) EnumUnits units,
    @Default(3) int precision,
     @Default(false) bool isSvgOverlayVisible,
  }) = _TrapezoidalUserSelection;

  factory TrapezoidalUserSelection.fromJson(Map<String, dynamic> json) =>
      _$TrapezoidalUserSelectionFromJson(json);
}
