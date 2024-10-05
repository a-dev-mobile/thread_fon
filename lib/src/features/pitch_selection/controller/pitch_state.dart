part of 'pitch_controller.dart';

@freezed
class PitchState with _$PitchState {
  const factory PitchState({
    @Default([]) List<PitchModel> model,
    @Default(EnumScreenStatus.initial) EnumScreenStatus status,
    ErrorState? error,
  }) = _PitchState;
}
