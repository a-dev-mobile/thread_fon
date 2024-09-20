// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'm_thread_tolerance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MThreadToleranceModel _$$_MThreadToleranceModelFromJson(
        Map<String, dynamic> json) =>
    _$_MThreadToleranceModel(
      id: json['id'] as String? ?? '',
      listTolerance: (json['listTolerance'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$$_MThreadToleranceModelToJson(
        _$_MThreadToleranceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'listTolerance': instance.listTolerance,
    };
