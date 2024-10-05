import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:threadfon/src/common/constant/enums_thread_type.dart';

part 'user_selection.freezed.dart';
part 'user_selection.g.dart'; // Если вы планируете использовать JSON сериализацию

@freezed
class UserSelection with _$UserSelection {
  const factory UserSelection({
    EnumThreadType? threadType,
    double? diameter,
    int? id,
    double? step,
    String? tolerance,
  }) = _UserSelection;

  factory UserSelection.fromJson(Map<String, dynamic> json) =>
      _$UserSelectionFromJson(json);
}
