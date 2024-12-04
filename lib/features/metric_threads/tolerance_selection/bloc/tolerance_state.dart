part of 'tolerance_bloc.dart';

@freezed
class ToleranceState with _$ToleranceState {
  const factory ToleranceState({
    @Default([]) List<ToleranceModel> tolerances,
    @Default(EnumStatus.loading) EnumStatus enumPageStatus,
    @Default(EnumNavigationStatus.initial)
    EnumNavigationStatus enumNavigationStatus,
    String? errorMsg,
  }) = _ToleranceState;

  factory ToleranceState.fromJson(Map<String, dynamic> json) =>
      _$ToleranceStateFromJson(json);
}
