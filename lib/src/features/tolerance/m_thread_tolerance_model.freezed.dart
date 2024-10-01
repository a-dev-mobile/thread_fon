// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'm_thread_tolerance_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MThreadToleranceModel _$MThreadToleranceModelFromJson(
    Map<String, dynamic> json) {
  return _MThreadToleranceModel.fromJson(json);
}

/// @nodoc
mixin _$MThreadToleranceModel {
  String get id => throw _privateConstructorUsedError;
  List<String> get listTolerance => throw _privateConstructorUsedError;

  /// Serializes this MThreadToleranceModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MThreadToleranceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MThreadToleranceModelCopyWith<MThreadToleranceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MThreadToleranceModelCopyWith<$Res> {
  factory $MThreadToleranceModelCopyWith(MThreadToleranceModel value,
          $Res Function(MThreadToleranceModel) then) =
      _$MThreadToleranceModelCopyWithImpl<$Res, MThreadToleranceModel>;
  @useResult
  $Res call({String id, List<String> listTolerance});
}

/// @nodoc
class _$MThreadToleranceModelCopyWithImpl<$Res,
        $Val extends MThreadToleranceModel>
    implements $MThreadToleranceModelCopyWith<$Res> {
  _$MThreadToleranceModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MThreadToleranceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? listTolerance = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      listTolerance: null == listTolerance
          ? _value.listTolerance
          : listTolerance // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MThreadToleranceModelImplCopyWith<$Res>
    implements $MThreadToleranceModelCopyWith<$Res> {
  factory _$$MThreadToleranceModelImplCopyWith(
          _$MThreadToleranceModelImpl value,
          $Res Function(_$MThreadToleranceModelImpl) then) =
      __$$MThreadToleranceModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, List<String> listTolerance});
}

/// @nodoc
class __$$MThreadToleranceModelImplCopyWithImpl<$Res>
    extends _$MThreadToleranceModelCopyWithImpl<$Res,
        _$MThreadToleranceModelImpl>
    implements _$$MThreadToleranceModelImplCopyWith<$Res> {
  __$$MThreadToleranceModelImplCopyWithImpl(_$MThreadToleranceModelImpl _value,
      $Res Function(_$MThreadToleranceModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of MThreadToleranceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? listTolerance = null,
  }) {
    return _then(_$MThreadToleranceModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      listTolerance: null == listTolerance
          ? _value._listTolerance
          : listTolerance // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MThreadToleranceModelImpl implements _MThreadToleranceModel {
  _$MThreadToleranceModelImpl(
      {this.id = '', final List<String> listTolerance = const <String>[]})
      : _listTolerance = listTolerance;

  factory _$MThreadToleranceModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MThreadToleranceModelImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  final List<String> _listTolerance;
  @override
  @JsonKey()
  List<String> get listTolerance {
    if (_listTolerance is EqualUnmodifiableListView) return _listTolerance;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listTolerance);
  }

  @override
  String toString() {
    return 'MThreadToleranceModel(id: $id, listTolerance: $listTolerance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MThreadToleranceModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality()
                .equals(other._listTolerance, _listTolerance));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, const DeepCollectionEquality().hash(_listTolerance));

  /// Create a copy of MThreadToleranceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MThreadToleranceModelImplCopyWith<_$MThreadToleranceModelImpl>
      get copyWith => __$$MThreadToleranceModelImplCopyWithImpl<
          _$MThreadToleranceModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MThreadToleranceModelImplToJson(
      this,
    );
  }
}

abstract class _MThreadToleranceModel implements MThreadToleranceModel {
  factory _MThreadToleranceModel(
      {final String id,
      final List<String> listTolerance}) = _$MThreadToleranceModelImpl;

  factory _MThreadToleranceModel.fromJson(Map<String, dynamic> json) =
      _$MThreadToleranceModelImpl.fromJson;

  @override
  String get id;
  @override
  List<String> get listTolerance;

  /// Create a copy of MThreadToleranceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MThreadToleranceModelImplCopyWith<_$MThreadToleranceModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
