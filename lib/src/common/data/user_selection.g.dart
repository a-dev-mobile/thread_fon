// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_selection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserSelectionImpl _$$UserSelectionImplFromJson(Map<String, dynamic> json) =>
    _$UserSelectionImpl(
      threadType: $enumDecodeNullable(_$ThreadTypeEnumMap, json['threadType']),
      diam: (json['diam'] as num?)?.toDouble(),
      id: (json['id'] as num?)?.toInt(),
      step: (json['step'] as num?)?.toDouble(),
      tolerance: json['tolerance'] as String?,
    );

Map<String, dynamic> _$$UserSelectionImplToJson(_$UserSelectionImpl instance) =>
    <String, dynamic>{
      'threadType': _$ThreadTypeEnumMap[instance.threadType],
      'diam': instance.diam,
      'id': instance.id,
      'step': instance.step,
      'tolerance': instance.tolerance,
    };

const _$ThreadTypeEnumMap = {
  ThreadType.external: 'external',
  ThreadType.internal: 'internal',
};
