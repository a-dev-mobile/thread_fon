part of 'trapezoidal_tolerance_bloc.dart';

@freezed
@immutable
sealed class TrapezoidalToleranceState with _$TrapezoidalToleranceState {
  const factory TrapezoidalToleranceState({
    @Default(<TrapezoidalToleranceItem>[]) List<TrapezoidalToleranceItem> femaleTolerances,
    @Default(<TrapezoidalToleranceItem>[]) List<TrapezoidalToleranceItem> maleTolerances,
    @Default(EnumStatus.loading) EnumStatus enumPageStatus,
    @Default(EnumNavigationStatus.initial) EnumNavigationStatus enumNavigationStatus,
    @Default(EnumThreadMaleFemale.male) EnumThreadMaleFemale selectedThreadType,
    String? errorMsg,
  }) = _TrapezoidalToleranceState;

  factory TrapezoidalToleranceState.fromJson(Map<String, dynamic> json) => _$TrapezoidalToleranceStateFromJson(json);
}
