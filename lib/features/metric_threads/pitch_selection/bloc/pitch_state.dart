part of 'pitch_bloc.dart';

@freezed
class PitchState with _$PitchState {
  const factory PitchState({
    @Default(<PitchModel>[]) List<PitchModel> pitches,
    @Default(EnumStatus.loading) EnumStatus enumPageStatus,
    @Default(EnumNavigationStatus.initial)
    EnumNavigationStatus enumNavigationStatus,
    String? errorMsg,
  }) = _PitchState;

  factory PitchState.fromJson(Map<String, dynamic> json) =>
      _$PitchStateFromJson(json);
}
