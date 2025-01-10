part of 'trapezoidal_thread_bloc.dart';

@freezed
@immutable
sealed class TrapezoidalThreadState with _$TrapezoidalThreadState {
  const factory TrapezoidalThreadState({
    @Default(<TrapezoidalThreadModel>[]) List<TrapezoidalThreadModel> threads,
    @Default(EnumStatus.loading) EnumStatus enumPageStatus,
    @Default(EnumNavigationStatus.initial) EnumNavigationStatus enumNavigationStatus,
    @Default(0.0) double scrollPosition,
    String? errorMsg,

  }) = _TrapezoidalThreadState;

    factory TrapezoidalThreadState.fromJson(Map<String, dynamic> json) => _$TrapezoidalThreadStateFromJson(json);

}
