part of 'diameter_bloc.dart';

@freezed
class DiameterState with _$DiameterState {
  const factory DiameterState({
    @Default([]) List<DiameterModel> diameters,
    @Default(EnumStatus.loading) EnumStatus enumPageStatus,
    @Default(EnumNavigationStatus.initial)
    EnumNavigationStatus enumNavigationStatus,
    String? errorMsg,
    @Default(0.0) double scrollPosition,
  }) = _DiameterState;

  factory DiameterState.fromJson(Map<String, dynamic> json) =>
      _$DiameterStateFromJson(json);
}
