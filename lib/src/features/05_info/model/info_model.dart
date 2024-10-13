import 'package:freezed_annotation/freezed_annotation.dart';

part 'info_model.freezed.dart';
part 'info_model.g.dart';

@freezed
class InfoModel with _$InfoModel {
  const factory InfoModel({
    required String description,
    required String info,
    required int id,
  }) = _InfoModel;

  factory InfoModel.fromJson(Map<String, dynamic> json) => _$InfoModelFromJson(json);
}
