part of 'imperial_tolerance_bloc.dart';

@freezed
@immutable
class ImperialToleranceState with _$ImperialToleranceState {
  const factory ImperialToleranceState({
    @Default(<ImperialToleranceItem>[])
    List<ImperialToleranceItem> femaleTolerances,
    @Default(<ImperialToleranceItem>[])
    List<ImperialToleranceItem> maleTolerances,
    @Default(EnumStatus.loading) EnumStatus enumPageStatus,
    @Default(EnumNavigationStatus.initial)
    EnumNavigationStatus enumNavigationStatus,
    @Default(EnumThreadMaleFemale.male) EnumThreadMaleFemale selectedThreadType,
    String? errorMsg,
  }) = _ImperialToleranceState;

  factory ImperialToleranceState.fromJson(Map<String, dynamic> json) =>
      _$ImperialToleranceStateFromJson(json);
}
