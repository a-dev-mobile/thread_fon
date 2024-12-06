part of 'imperial_diameter_bloc.dart';

@freezed
class ImperialDiameterState with _$ImperialDiameterState {
  const factory ImperialDiameterState({
    @Default([]) List<ImperialDiameterModel> diameters,
    @Default(EnumStatus.loading) EnumStatus enumPageStatus,
    @Default(EnumNavigationStatus.initial) EnumNavigationStatus enumNavigationStatus,
    String? errorMsg,
    @Default(0.0) double scrollPosition,
  }) = _ImperialDiameterState;

  factory ImperialDiameterState.fromJson(Map<String, dynamic> json) =>
      _$ImperialDiameterStateFromJson(json);
}
