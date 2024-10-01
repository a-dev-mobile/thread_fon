// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'm_thread_diam_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MThreadDiamModel _$MThreadDiamModelFromJson(Map<String, dynamic> json) {
  return _MThreadDiamModel.fromJson(json);
}

/// @nodoc
mixin _$MThreadDiamModel {
  String get diam => throw _privateConstructorUsedError;

  /// Serializes this MThreadDiamModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MThreadDiamModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MThreadDiamModelCopyWith<MThreadDiamModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MThreadDiamModelCopyWith<$Res> {
  factory $MThreadDiamModelCopyWith(
          MThreadDiamModel value, $Res Function(MThreadDiamModel) then) =
      _$MThreadDiamModelCopyWithImpl<$Res, MThreadDiamModel>;
  @useResult
  $Res call({String diam});
}

/// @nodoc
class _$MThreadDiamModelCopyWithImpl<$Res, $Val extends MThreadDiamModel>
    implements $MThreadDiamModelCopyWith<$Res> {
  _$MThreadDiamModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MThreadDiamModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? diam = null,
  }) {
    return _then(_value.copyWith(
      diam: null == diam
          ? _value.diam
          : diam // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MThreadDiamModelImplCopyWith<$Res>
    implements $MThreadDiamModelCopyWith<$Res> {
  factory _$$MThreadDiamModelImplCopyWith(_$MThreadDiamModelImpl value,
          $Res Function(_$MThreadDiamModelImpl) then) =
      __$$MThreadDiamModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String diam});
}

/// @nodoc
class __$$MThreadDiamModelImplCopyWithImpl<$Res>
    extends _$MThreadDiamModelCopyWithImpl<$Res, _$MThreadDiamModelImpl>
    implements _$$MThreadDiamModelImplCopyWith<$Res> {
  __$$MThreadDiamModelImplCopyWithImpl(_$MThreadDiamModelImpl _value,
      $Res Function(_$MThreadDiamModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of MThreadDiamModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? diam = null,
  }) {
    return _then(_$MThreadDiamModelImpl(
      diam: null == diam
          ? _value.diam
          : diam // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MThreadDiamModelImpl implements _MThreadDiamModel {
  _$MThreadDiamModelImpl({required this.diam});

  factory _$MThreadDiamModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MThreadDiamModelImplFromJson(json);

  @override
  final String diam;

  @override
  String toString() {
    return 'MThreadDiamModel(diam: $diam)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MThreadDiamModelImpl &&
            (identical(other.diam, diam) || other.diam == diam));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, diam);

  /// Create a copy of MThreadDiamModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MThreadDiamModelImplCopyWith<_$MThreadDiamModelImpl> get copyWith =>
      __$$MThreadDiamModelImplCopyWithImpl<_$MThreadDiamModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MThreadDiamModelImplToJson(
      this,
    );
  }
}

abstract class _MThreadDiamModel implements MThreadDiamModel {
  factory _MThreadDiamModel({required final String diam}) =
      _$MThreadDiamModelImpl;

  factory _MThreadDiamModel.fromJson(Map<String, dynamic> json) =
      _$MThreadDiamModelImpl.fromJson;

  @override
  String get diam;

  /// Create a copy of MThreadDiamModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MThreadDiamModelImplCopyWith<_$MThreadDiamModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
