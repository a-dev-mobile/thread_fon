// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'm_thread_tolerance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MThreadToleranceModelImpl _$$MThreadToleranceModelImplFromJson(
        Map<String, dynamic> json) =>
    _$MThreadToleranceModelImpl(
      id: json['id'] as String? ?? '',
      listTolerance: (json['listTolerance'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$$MThreadToleranceModelImplToJson(
        _$MThreadToleranceModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'listTolerance': instance.listTolerance,
    };
