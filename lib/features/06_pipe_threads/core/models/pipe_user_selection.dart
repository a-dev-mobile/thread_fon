import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:threadfon/core/constant/enum_units.dart';

part 'pipe_user_selection.freezed.dart';
part 'pipe_user_selection.g.dart';

@freezed
@immutable
class PipeUserSelection with _$PipeUserSelection {
  const factory PipeUserSelection({
    int? id,
    @Default(EnumUnits.mm) EnumUnits units,
    @Default(3) int precision,
    @Default(false) bool isSvgOverlayVisible,
  }) = _PipeUserSelection;

  factory PipeUserSelection.fromJson(Map<String, dynamic> json) =>
      _$PipeUserSelectionFromJson(json);
}
