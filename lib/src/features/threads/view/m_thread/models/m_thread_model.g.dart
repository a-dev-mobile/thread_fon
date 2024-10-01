// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'm_thread_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MThreadModelImpl _$$MThreadModelImplFromJson(Map<String, dynamic> json) =>
    _$MThreadModelImpl(
      id: json['id'] as String? ?? '',
      diam: json['diam'] as String? ?? '',
      tolerance: json['tolerance'] as String? ?? '',
      isCoarsePitch: json['isCoarsePitch'] as bool? ?? false,
      isFinePitch: json['isFinePitch'] as bool? ?? false,
      isSuperFinePitch: json['isSuperFinePitch'] as bool? ?? false,
      isMale: json['isMale'] as bool? ?? false,
      es_d: (json['es_d'] as num?)?.toDouble() ?? 0.0,
      ei_d: (json['ei_d'] as num?)?.toDouble() ?? 0.0,
      es_d1: (json['es_d1'] as num?)?.toDouble() ?? 0.0,
      ei_d1: (json['ei_d1'] as num?)?.toDouble() ?? 0.0,
      es_d2: (json['es_d2'] as num?)?.toDouble() ?? 0.0,
      ei_d2: (json['ei_d2'] as num?)?.toDouble() ?? 0.0,
      pitch: json['pitch'] as String? ?? '',
    );

Map<String, dynamic> _$$MThreadModelImplToJson(_$MThreadModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'diam': instance.diam,
      'tolerance': instance.tolerance,
      'isCoarsePitch': instance.isCoarsePitch,
      'isFinePitch': instance.isFinePitch,
      'isSuperFinePitch': instance.isSuperFinePitch,
      'isMale': instance.isMale,
      'es_d': instance.es_d,
      'ei_d': instance.ei_d,
      'es_d1': instance.es_d1,
      'ei_d1': instance.ei_d1,
      'es_d2': instance.es_d2,
      'ei_d2': instance.ei_d2,
      'pitch': instance.pitch,
    };
