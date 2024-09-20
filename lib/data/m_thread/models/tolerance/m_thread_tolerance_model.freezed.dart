// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'm_thread_tolerance_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MThreadToleranceModel _$MThreadToleranceModelFromJson(
    Map<String, dynamic> json) {
  return _MThreadToleranceModel.fromJson(json);
}

/// @nodoc
class _$MThreadToleranceModelTearOff {
  const _$MThreadToleranceModelTearOff();

  _MThreadToleranceModel call(
      {String id = '', List<String> listTolerance = const <String>[]}) {
    return _MThreadToleranceModel(
      id: id,
      listTolerance: listTolerance,
    );
  }

  MThreadToleranceModel fromJson(Map<String, Object?> json) {
    return MThreadToleranceModel.fromJson(json);
  }
}

/// @nodoc
const $MThreadToleranceModel = _$MThreadToleranceModelTearOff();

/// @nodoc
mixin _$MThreadToleranceModel {
  String get id => throw _privateConstructorUsedError;
  List<String> get listTolerance => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MThreadToleranceModelCopyWith<MThreadToleranceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MThreadToleranceModelCopyWith<$Res> {
  factory $MThreadToleranceModelCopyWith(MThreadToleranceModel value,
          $Res Function(MThreadToleranceModel) then) =
      _$MThreadToleranceModelCopyWithImpl<$Res>;
  $Res call({String id, List<String> listTolerance});
}

/// @nodoc
class _$MThreadToleranceModelCopyWithImpl<$Res>
    implements $MThreadToleranceModelCopyWith<$Res> {
  _$MThreadToleranceModelCopyWithImpl(this._value, this._then);

  final MThreadToleranceModel _value;
  // ignore: unused_field
  final $Res Function(MThreadToleranceModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? listTolerance = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      listTolerance: listTolerance == freezed
          ? _value.listTolerance
          : listTolerance // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
abstract class _$MThreadToleranceModelCopyWith<$Res>
    implements $MThreadToleranceModelCopyWith<$Res> {
  factory _$MThreadToleranceModelCopyWith(_MThreadToleranceModel value,
          $Res Function(_MThreadToleranceModel) then) =
      __$MThreadToleranceModelCopyWithImpl<$Res>;
  @override
  $Res call({String id, List<String> listTolerance});
}

/// @nodoc
class __$MThreadToleranceModelCopyWithImpl<$Res>
    extends _$MThreadToleranceModelCopyWithImpl<$Res>
    implements _$MThreadToleranceModelCopyWith<$Res> {
  __$MThreadToleranceModelCopyWithImpl(_MThreadToleranceModel _value,
      $Res Function(_MThreadToleranceModel) _then)
      : super(_value, (v) => _then(v as _MThreadToleranceModel));

  @override
  _MThreadToleranceModel get _value => super._value as _MThreadToleranceModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? listTolerance = freezed,
  }) {
    return _then(_MThreadToleranceModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      listTolerance: listTolerance == freezed
          ? _value.listTolerance
          : listTolerance // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MThreadToleranceModel implements _MThreadToleranceModel {
  _$_MThreadToleranceModel(
      {this.id = '', this.listTolerance = const <String>[]});

  factory _$_MThreadToleranceModel.fromJson(Map<String, dynamic> json) =>
      _$$_MThreadToleranceModelFromJson(json);

  @JsonKey()
  @override
  final String id;
  @JsonKey()
  @override
  final List<String> listTolerance;

  @override
  String toString() {
    return 'MThreadToleranceModel(id: $id, listTolerance: $listTolerance)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MThreadToleranceModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality()
                .equals(other.listTolerance, listTolerance));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(listTolerance));

  @JsonKey(ignore: true)
  @override
  _$MThreadToleranceModelCopyWith<_MThreadToleranceModel> get copyWith =>
      __$MThreadToleranceModelCopyWithImpl<_MThreadToleranceModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MThreadToleranceModelToJson(this);
  }
}

abstract class _MThreadToleranceModel implements MThreadToleranceModel {
  factory _MThreadToleranceModel({String id, List<String> listTolerance}) =
      _$_MThreadToleranceModel;

  factory _MThreadToleranceModel.fromJson(Map<String, dynamic> json) =
      _$_MThreadToleranceModel.fromJson;

  @override
  String get id;
  @override
  List<String> get listTolerance;
  @override
  @JsonKey(ignore: true)
  _$MThreadToleranceModelCopyWith<_MThreadToleranceModel> get copyWith =>
      throw _privateConstructorUsedError;
}
