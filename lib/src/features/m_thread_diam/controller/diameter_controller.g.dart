// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diameter_controller.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DiameterStateImpl _$$DiameterStateImplFromJson(Map<String, dynamic> json) =>
    _$DiameterStateImpl(
      diameters: (json['diameters'] as List<dynamic>?)
              ?.map((e) => DiameterModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      status: $enumDecodeNullable(_$EnumStatusEnumMap, json['status']) ??
          EnumStatus.init,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$$DiameterStateImplToJson(_$DiameterStateImpl instance) =>
    <String, dynamic>{
      'diameters': instance.diameters,
      'status': _$EnumStatusEnumMap[instance.status]!,
      'error': instance.error,
    };

const _$EnumStatusEnumMap = {
  EnumStatus.init: 'init',
  EnumStatus.load: 'load',
  EnumStatus.success: 'success',
  EnumStatus.error: 'error',
  EnumStatus.transition: 'transition',
};
