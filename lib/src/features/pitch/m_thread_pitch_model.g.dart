// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'm_thread_pitch_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MThreadPitchModelImpl _$$MThreadPitchModelImplFromJson(
        Map<String, dynamic> json) =>
    _$MThreadPitchModelImpl(
      isCoarse: json['isCoarse'] as bool? ?? false,
      isFine: json['isFine'] as bool? ?? false,
      isSuperFine: json['isSuperFine'] as bool? ?? false,
      pitchCoarse: json['pitchCoarse'] as String? ?? '',
      pitchsFine: (json['pitchsFine'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      pitchsSuperFine: (json['pitchsSuperFine'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$$MThreadPitchModelImplToJson(
        _$MThreadPitchModelImpl instance) =>
    <String, dynamic>{
      'isCoarse': instance.isCoarse,
      'isFine': instance.isFine,
      'isSuperFine': instance.isSuperFine,
      'pitchCoarse': instance.pitchCoarse,
      'pitchsFine': instance.pitchsFine,
      'pitchsSuperFine': instance.pitchsSuperFine,
    };
