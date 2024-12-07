import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:threadfon/core/constant/enum_thread.dart';
import 'package:threadfon/features/thread_type_selection/models/thread_type_model.dart';

part 'core_user_selection.freezed.dart';
part 'core_user_selection.g.dart';

@freezed
class CoreUserSelection with _$CoreUserSelection {
  const factory CoreUserSelection({
    @Default(EnumThreadMaleFemale.male)  EnumThreadMaleFemale threadType,
    @Default(EnumThreads.metric) EnumThreads enumThreads,
  }) = _CoreUserSelection;

  factory CoreUserSelection.fromJson(Map<String, dynamic> json) => _$CoreUserSelectionFromJson(json);
}
