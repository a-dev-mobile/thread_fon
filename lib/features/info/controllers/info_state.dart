part of 'info_controller.dart';

@freezed
class InfoState with _$InfoState {
  const factory InfoState({
    @Default([]) List<InfoModel> model,
    @Default(EnumScreenStatus.initial) EnumScreenStatus status,
    ErrorState? error,
    String? svgData,
  }) = _InfoState;
}
