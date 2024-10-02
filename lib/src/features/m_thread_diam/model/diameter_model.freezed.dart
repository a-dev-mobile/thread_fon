// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diameter_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DiameterModel _$DiameterModelFromJson(Map<String, dynamic> json) {
  return _DiameterModel.fromJson(json);
}

/// @nodoc
mixin _$DiameterModel {
  int get id => throw _privateConstructorUsedError;
  double get diam => throw _privateConstructorUsedError;

  /// Serializes this DiameterModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiameterModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiameterModelCopyWith<DiameterModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiameterModelCopyWith<$Res> {
  factory $DiameterModelCopyWith(
          DiameterModel value, $Res Function(DiameterModel) then) =
      _$DiameterModelCopyWithImpl<$Res, DiameterModel>;
  @useResult
  $Res call({int id, double diam});
}

/// @nodoc
class _$DiameterModelCopyWithImpl<$Res, $Val extends DiameterModel>
    implements $DiameterModelCopyWith<$Res> {
  _$DiameterModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiameterModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? diam = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      diam: null == diam
          ? _value.diam
          : diam // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DiameterModelImplCopyWith<$Res>
    implements $DiameterModelCopyWith<$Res> {
  factory _$$DiameterModelImplCopyWith(
          _$DiameterModelImpl value, $Res Function(_$DiameterModelImpl) then) =
      __$$DiameterModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, double diam});
}

/// @nodoc
class __$$DiameterModelImplCopyWithImpl<$Res>
    extends _$DiameterModelCopyWithImpl<$Res, _$DiameterModelImpl>
    implements _$$DiameterModelImplCopyWith<$Res> {
  __$$DiameterModelImplCopyWithImpl(
      _$DiameterModelImpl _value, $Res Function(_$DiameterModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of DiameterModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? diam = null,
  }) {
    return _then(_$DiameterModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      diam: null == diam
          ? _value.diam
          : diam // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DiameterModelImpl implements _DiameterModel {
  const _$DiameterModelImpl({required this.id, required this.diam});

  factory _$DiameterModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiameterModelImplFromJson(json);

  @override
  final int id;
  @override
  final double diam;

  @override
  String toString() {
    return 'DiameterModel(id: $id, diam: $diam)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiameterModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.diam, diam) || other.diam == diam));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, diam);

  /// Create a copy of DiameterModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiameterModelImplCopyWith<_$DiameterModelImpl> get copyWith =>
      __$$DiameterModelImplCopyWithImpl<_$DiameterModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DiameterModelImplToJson(
      this,
    );
  }
}

abstract class _DiameterModel implements DiameterModel {
  const factory _DiameterModel(
      {required final int id,
      required final double diam}) = _$DiameterModelImpl;

  factory _DiameterModel.fromJson(Map<String, dynamic> json) =
      _$DiameterModelImpl.fromJson;

  @override
  int get id;
  @override
  double get diam;

  /// Create a copy of DiameterModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiameterModelImplCopyWith<_$DiameterModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
