import 'dart:ui';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

class ToggleLangCubit extends Cubit<String> {
  ToggleLangCubit() : super(window.locale.languageCode);

  void setLocaleEN() {
    emit('en');
  }

  void setLocaleRU() {
    emit('ru');
  }
}
