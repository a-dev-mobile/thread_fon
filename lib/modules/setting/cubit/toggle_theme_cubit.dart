// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';


class ToggleThemeCubit extends Cubit<bool> {
  ToggleThemeCubit() : super(false);

  void toggleTheme({required bool isDark}) {
    emit(isDark);
  }


}
