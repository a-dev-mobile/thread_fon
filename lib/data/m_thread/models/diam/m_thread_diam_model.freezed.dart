// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'm_thread_diam_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MThreadDiamModel _$MThreadDiamModelFromJson(Map<String, dynamic> json) {
  return _MThreadDiamModel.fromJson(json);
}

/// @nodoc
class _$MThreadDiamModelTearOff {
  const _$MThreadDiamModelTearOff();

  _MThreadDiamModel call({required String diam}) {
    return _MThreadDiamModel(
      diam: diam,
    );
  }

  MThreadDiamModel fromJson(Map<String, Object?> json) {
    return MThreadDiamModel.fromJson(json);
  }
}

/// @nodoc
const $MThreadDiamModel = _$MThreadDiamModelTearOff();

/// @nodoc
mixin _$MThreadDiamModel {
  String get diam => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MThreadDiamModelCopyWith<MThreadDiamModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MThreadDiamModelCopyWith<$Res> {
  factory $MThreadDiamModelCopyWith(
          MThreadDiamModel value, $Res Function(MThreadDiamModel) then) =
      _$MThreadDiamModelCopyWithImpl<$Res>;
  $Res call({String diam});
}

/// @nodoc
class _$MThreadDiamModelCopyWithImpl<$Res>
    implements $MThreadDiamModelCopyWith<$Res> {
  _$MThreadDiamModelCopyWithImpl(this._value, this._then);

  final MThreadDiamModel _value;
  // ignore: unused_field
  final $Res Function(MThreadDiamModel) _then;

  @override
  $Res call({
    Object? diam = freezed,
  }) {
    return _then(_value.copyWith(
      diam: diam == freezed
          ? _value.diam
          : diam // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$MThreadDiamModelCopyWith<$Res>
    implements $MThreadDiamModelCopyWith<$Res> {
  factory _$MThreadDiamModelCopyWith(
          _MThreadDiamModel value, $Res Function(_MThreadDiamModel) then) =
      __$MThreadDiamModelCopyWithImpl<$Res>;
  @override
  $Res call({String diam});
}

/// @nodoc
class __$MThreadDiamModelCopyWithImpl<$Res>
    extends _$MThreadDiamModelCopyWithImpl<$Res>
    implements _$MThreadDiamModelCopyWith<$Res> {
  __$MThreadDiamModelCopyWithImpl(
      _MThreadDiamModel _value, $Res Function(_MThreadDiamModel) _then)
      : super(_value, (v) => _then(v as _MThreadDiamModel));

  @override
  _MThreadDiamModel get _value => super._value as _MThreadDiamModel;

  @override
  $Res call({
    Object? diam = freezed,
  }) {
    return _then(_MThreadDiamModel(
      diam: diam == freezed
          ? _value.diam
          : diam // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MThreadDiamModel implements _MThreadDiamModel {
  _$_MThreadDiamModel({required this.diam});

  factory _$_MThreadDiamModel.fromJson(Map<String, dynamic> json) =>
      _$$_MThreadDiamModelFromJson(json);

  @override
  final String diam;

  @override
  String toString() {
    return 'MThreadDiamModel(diam: $diam)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MThreadDiamModel &&
            const DeepCollectionEquality().equals(other.diam, diam));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(diam));

  @JsonKey(ignore: true)
  @override
  _$MThreadDiamModelCopyWith<_MThreadDiamModel> get copyWith =>
      __$MThreadDiamModelCopyWithImpl<_MThreadDiamModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MThreadDiamModelToJson(this);
  }
}

abstract class _MThreadDiamModel implements MThreadDiamModel {
  factory _MThreadDiamModel({required String diam}) = _$_MThreadDiamModel;

  factory _MThreadDiamModel.fromJson(Map<String, dynamic> json) =
      _$_MThreadDiamModel.fromJson;

  @override
  String get diam;
  @override
  @JsonKey(ignore: true)
  _$MThreadDiamModelCopyWith<_MThreadDiamModel> get copyWith =>
      throw _privateConstructorUsedError;
}
