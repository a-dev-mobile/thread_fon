part of 'tolerance_bloc.dart';

@freezed
class ToleranceState with _$ToleranceState {
  const factory ToleranceState({
    @Default([]) List<ToleranceModel> tolerances,
    @Default(EnumStatus.loading) EnumStatus status,
    String? errorMsg,
  }) = _ToleranceState;

  factory ToleranceState.fromJson(Map<String, dynamic> json) =>
      _$ToleranceStateFromJson(json);
}
