import 'package:freezed_annotation/freezed_annotation.dart';

part 'thread_type_model.freezed.dart';
part 'thread_type_model.g.dart';

@freezed
class ThreadTypeModel with _$ThreadTypeModel {
  const factory ThreadTypeModel({
    required EnumThreadType enumThreadType,
    required String svgAssetPath,
  }) = _ThreadTypeModel;

  factory ThreadTypeModel.fromJson(Map<String, dynamic> json) =>
      _$ThreadTypeModelFromJson(json);
}

enum EnumThreadType { f, m }
