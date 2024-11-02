import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_state.freezed.dart';

@freezed
class ErrorState with _$ErrorState {
  const factory ErrorState({
    required Exception exception,
    required StackTrace stackTrace,
    String? msgUser,
  }) = _ErrorState;
}
