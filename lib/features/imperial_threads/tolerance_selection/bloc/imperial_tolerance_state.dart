part of 'imperial_tolerance_bloc.dart';

@freezed
class ImperialToleranceState with _$ImperialToleranceState {
  const factory ImperialToleranceState({
    @Default([]) List<ImperialToleranceItem> femaleTolerances,
    @Default([]) List<ImperialToleranceItem> maleTolerances,
    @Default(EnumStatus.loading) EnumStatus enumPageStatus,
    @Default(EnumNavigationStatus.initial)
    EnumNavigationStatus enumNavigationStatus,
    @Default(EnumThreadMaleFemale.male) EnumThreadMaleFemale selectedThreadType,
    String? errorMsg,
  }) = _ImperialToleranceState;

  factory ImperialToleranceState.fromJson(Map<String, dynamic> json) =>
      _$ImperialToleranceStateFromJson(json);
}
