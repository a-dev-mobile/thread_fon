part of 'diameter_controller.dart';

@freezed
class DiameterState with _$DiameterState {
  const factory DiameterState({
    @Default([]) List<DiameterModel> diameters,
    @Default(EnumStatus.init) EnumStatus status,
    String? error,
  }) = _DiameterState;

  factory DiameterState.fromJson(Map<String, dynamic> json) =>
      _$DiameterStateFromJson(json);
}
