part of 'info_bloc.dart';

@freezed
class InfoState with _$InfoState {
  const factory InfoState({
    InfoModel? model,
    String? svgData,
    String? svgDataNoDimensions,
    @Default(false) bool isSvgDataLoaded, 
    @Default(EnumPageStatus.loading) EnumPageStatus enumPageStatus,
    @Default(EnumNavigationStatus.initial) EnumNavigationStatus enumNavigationStatus,
    String? errorMsg,
    @Default(EnumUnits.mm) EnumUnits units,
    @Default(3) int precision,
  }) = _InfoState;

  factory InfoState.fromJson(Map<String, dynamic> json) => _$InfoStateFromJson(json);
}
