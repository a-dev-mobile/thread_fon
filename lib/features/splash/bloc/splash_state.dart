part of 'splash_bloc.dart';

@freezed
class SplashState with _$SplashState {
  const factory SplashState({
    
    @Default(EnumPageStatus.loading) EnumPageStatus enumPageStatus,
    @Default(EnumNavigationStatus.initial)
    EnumNavigationStatus enumNavigationStatus,
    String? errorMsg,

  }) = _SplashState;

  factory SplashState.fromJson(Map<String, dynamic> json) =>
      _$SplashStateFromJson(json);
}
