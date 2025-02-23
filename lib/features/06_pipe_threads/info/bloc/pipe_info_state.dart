part of 'pipe_info_bloc.dart';

@freezed
@immutable
sealed class PipeInfoState with _$PipeInfoState {
  const factory PipeInfoState({
    PipeInfoModel? model,
    String? svgDimensions,
    String? svgAnnotations,
    @Default(EnumStatus.loading) EnumStatus svgRequestStatus,
    @Default(EnumStatus.loading) EnumStatus enumPageStatus,
    @Default(EnumNavigationStatus.initial)
    EnumNavigationStatus enumNavigationStatus,
    String? errorMsg,
    String? svgErrorMsg,
    @Default(EnumUnits.mm) EnumUnits units,
    @Default(5) int precision,
    @Default(false) bool isSvgOverlayVisible,
    @Default(false) bool showDimensions,
  }) = _PipeInfoState;

  factory PipeInfoState.fromJson(Map<String, dynamic> json) =>
      _$PipeInfoStateFromJson(json);
}
