part of 'pipe_diameter_bloc.dart';

@freezed
@immutable
sealed class PipeDiameterState with _$PipeDiameterState {
  const factory PipeDiameterState({
    @Default(<PipeDiameterItem>[]) List<PipeDiameterItem> femaleDiameters,
    @Default(<PipeDiameterItem>[]) List<PipeDiameterItem> maleDiameters,
    @Default(EnumStatus.loading) EnumStatus enumPageStatus,
    @Default(EnumNavigationStatus.initial)
    EnumNavigationStatus enumNavigationStatus,
    @Default(EnumThreadMaleFemale.male) EnumThreadMaleFemale selectedThreadType,
    String? errorMsg,
  }) = _PipeDiameterState;

  factory PipeDiameterState.fromJson(Map<String, dynamic> json) =>
      _$PipeDiameterStateFromJson(json);
}
