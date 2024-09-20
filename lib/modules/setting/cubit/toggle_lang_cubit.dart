import 'dart:ui';

// Package imports:
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ToggleLangCubit extends HydratedCubit<String> {
  ToggleLangCubit() : super(window.locale.languageCode);

  void setLocaleEN() {
    emit('en');
  }

  void setLocaleRU() {
    emit('ru');
  }

  @override
  String fromJson(Map<String, dynamic> json) => json['lang_code'].toString();

  @override
  Map<String, dynamic>? toJson(String state) =>
      <String, dynamic>{'lang_code': state};
}
