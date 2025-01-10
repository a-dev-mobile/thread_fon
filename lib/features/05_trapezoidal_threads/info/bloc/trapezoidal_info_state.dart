part of 'trapezoidal_info_bloc.dart';

@freezed
@immutable
sealed class TrapezoidalInfoState with _$TrapezoidalInfoState {
  const factory TrapezoidalInfoState({
    TrapezoidalInfoModel? model,
    String? svgData,
    String? svgDataNoDimensions,
    @Default(EnumStatus.loading) EnumStatus svgRequestStatus,
    @Default(EnumStatus.loading) EnumStatus enumPageStatus,
    @Default(EnumNavigationStatus.initial)
    EnumNavigationStatus enumNavigationStatus,
    String? errorMsg,
    String? svgErrorMsg,
    @Default(EnumUnits.mm) EnumUnits units,
    @Default(5) int precision,
    @Default(false) bool isSvgOverlayVisible,
    @Default(true) bool showDimensions,
  }) = _TrapezoidalInfoState;

  factory TrapezoidalInfoState.fromJson(Map<String, dynamic> json) =>
      _$TrapezoidalInfoStateFromJson(json);
}
