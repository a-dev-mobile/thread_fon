part of 'imperial_info_bloc.dart';

@freezed
@immutable
sealed class ImperialInfoState with _$ImperialInfoState {
  const factory ImperialInfoState({
    ImperialInfoModel? model,
    String? svgDimensions,
    String? svgAnnotations,
    @Default(EnumStatus.loading) EnumStatus svgRequestStatus,
    @Default(EnumStatus.loading) EnumStatus enumPageStatus,
    @Default(EnumNavigationStatus.initial)
    EnumNavigationStatus enumNavigationStatus,
    String? errorMsg,
    String? svgErrorMsg,
    @Default(EnumUnits.inch) EnumUnits units,
    @Default(5) int precision,
    @Default(false) bool isSvgOverlayVisible,
    @Default(false) bool showDimensions,
  }) = _ImperialInfoState;

  factory ImperialInfoState.fromJson(Map<String, dynamic> json) =>
      _$ImperialInfoStateFromJson(json);
}
