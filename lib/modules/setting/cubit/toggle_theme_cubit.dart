// Package imports:
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ToggleThemeCubit extends HydratedCubit<bool> {
  ToggleThemeCubit() : super(false);

  void toggleTheme({required bool isDark}) {
    emit(isDark);
  }

  @override
  bool? fromJson(Map<String, dynamic> json) => json['isDark'] as bool;

  @override
  Map<String, dynamic>? toJson(bool state) =>
      <String, dynamic>{'isDark': state};
}
