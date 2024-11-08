part of 'info_bloc.dart';

@freezed
class InfoState with _$InfoState {
  const factory InfoState({
    InfoModel? model,
    String? svgData,
    @Default(EnumPageStatus.loading) EnumPageStatus enumPageStatus,

    @Default(EnumNavigationStatus.initial) EnumNavigationStatus enumNavigationStatus,
    String? errorMsg,
  }) = _InfoState;

  factory InfoState.fromJson(Map<String, dynamic> json) => _$InfoStateFromJson(json);
}
