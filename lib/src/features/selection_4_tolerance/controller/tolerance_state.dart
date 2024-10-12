part of 'tolerance_controller.dart';

@freezed
class ToleranceState with _$ToleranceState {
  const factory ToleranceState({
    @Default([]) List<ToleranceModel> model,
    @Default(EnumScreenStatus.initial) EnumScreenStatus status,
    ErrorState? error,
  }) = _ToleranceState;
}
