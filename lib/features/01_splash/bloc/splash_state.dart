part of 'splash_bloc.dart';

@freezed
@immutable
sealed class SplashState with _$SplashState {
  const SplashState._();
  const factory SplashState({
    @Default(EnumStatus.loading) EnumStatus enumPageStatus,
    @Default(EnumNavigationStatus.initial)
    EnumNavigationStatus enumNavigationStatus,
    String? errorMsg,
  }) = _SplashState;

  factory SplashState.fromJson(Map<String, dynamic> json) =>
      _$SplashStateFromJson(json);
}
