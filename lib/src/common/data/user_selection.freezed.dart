// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_selection.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserSelection _$UserSelectionFromJson(Map<String, dynamic> json) {
  return _UserSelection.fromJson(json);
}

/// @nodoc
mixin _$UserSelection {
  ThreadType? get threadType => throw _privateConstructorUsedError;
  double? get diameter => throw _privateConstructorUsedError;
  double? get step => throw _privateConstructorUsedError;
  String? get tolerance => throw _privateConstructorUsedError;

  /// Serializes this UserSelection to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserSelection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserSelectionCopyWith<UserSelection> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserSelectionCopyWith<$Res> {
  factory $UserSelectionCopyWith(
          UserSelection value, $Res Function(UserSelection) then) =
      _$UserSelectionCopyWithImpl<$Res, UserSelection>;
  @useResult
  $Res call(
      {ThreadType? threadType,
      double? diameter,
      double? step,
      String? tolerance});
}

/// @nodoc
class _$UserSelectionCopyWithImpl<$Res, $Val extends UserSelection>
    implements $UserSelectionCopyWith<$Res> {
  _$UserSelectionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserSelection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? threadType = freezed,
    Object? diameter = freezed,
    Object? step = freezed,
    Object? tolerance = freezed,
  }) {
    return _then(_value.copyWith(
      threadType: freezed == threadType
          ? _value.threadType
          : threadType // ignore: cast_nullable_to_non_nullable
              as ThreadType?,
      diameter: freezed == diameter
          ? _value.diameter
          : diameter // ignore: cast_nullable_to_non_nullable
              as double?,
      step: freezed == step
          ? _value.step
          : step // ignore: cast_nullable_to_non_nullable
              as double?,
      tolerance: freezed == tolerance
          ? _value.tolerance
          : tolerance // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserSelectionImplCopyWith<$Res>
    implements $UserSelectionCopyWith<$Res> {
  factory _$$UserSelectionImplCopyWith(
          _$UserSelectionImpl value, $Res Function(_$UserSelectionImpl) then) =
      __$$UserSelectionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ThreadType? threadType,
      double? diameter,
      double? step,
      String? tolerance});
}

/// @nodoc
class __$$UserSelectionImplCopyWithImpl<$Res>
    extends _$UserSelectionCopyWithImpl<$Res, _$UserSelectionImpl>
    implements _$$UserSelectionImplCopyWith<$Res> {
  __$$UserSelectionImplCopyWithImpl(
      _$UserSelectionImpl _value, $Res Function(_$UserSelectionImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserSelection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? threadType = freezed,
    Object? diameter = freezed,
    Object? step = freezed,
    Object? tolerance = freezed,
  }) {
    return _then(_$UserSelectionImpl(
      threadType: freezed == threadType
          ? _value.threadType
          : threadType // ignore: cast_nullable_to_non_nullable
              as ThreadType?,
      diameter: freezed == diameter
          ? _value.diameter
          : diameter // ignore: cast_nullable_to_non_nullable
              as double?,
      step: freezed == step
          ? _value.step
          : step // ignore: cast_nullable_to_non_nullable
              as double?,
      tolerance: freezed == tolerance
          ? _value.tolerance
          : tolerance // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserSelectionImpl implements _UserSelection {
  const _$UserSelectionImpl(
      {this.threadType, this.diameter, this.step, this.tolerance});

  factory _$UserSelectionImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserSelectionImplFromJson(json);

  @override
  final ThreadType? threadType;
  @override
  final double? diameter;
  @override
  final double? step;
  @override
  final String? tolerance;

  @override
  String toString() {
    return 'UserSelection(threadType: $threadType, diameter: $diameter, step: $step, tolerance: $tolerance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserSelectionImpl &&
            (identical(other.threadType, threadType) ||
                other.threadType == threadType) &&
            (identical(other.diameter, diameter) ||
                other.diameter == diameter) &&
            (identical(other.step, step) || other.step == step) &&
            (identical(other.tolerance, tolerance) ||
                other.tolerance == tolerance));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, threadType, diameter, step, tolerance);

  /// Create a copy of UserSelection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserSelectionImplCopyWith<_$UserSelectionImpl> get copyWith =>
      __$$UserSelectionImplCopyWithImpl<_$UserSelectionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserSelectionImplToJson(
      this,
    );
  }
}

abstract class _UserSelection implements UserSelection {
  const factory _UserSelection(
      {final ThreadType? threadType,
      final double? diameter,
      final double? step,
      final String? tolerance}) = _$UserSelectionImpl;

  factory _UserSelection.fromJson(Map<String, dynamic> json) =
      _$UserSelectionImpl.fromJson;

  @override
  ThreadType? get threadType;
  @override
  double? get diameter;
  @override
  double? get step;
  @override
  String? get tolerance;

  /// Create a copy of UserSelection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserSelectionImplCopyWith<_$UserSelectionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
