import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:threadfon/app/language/language_bloc.dart';
import 'package:threadfon/core/constant/assets.gen.dart';
import 'package:threadfon/core/constant/enum_screen_status.dart';
import 'package:threadfon/core/constant/enum_status.dart';
import 'package:threadfon/core/constant/enum_thread_type.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/features/thread_type_selection/models/thread_type_model.dart';

part 'thread_type_bloc.freezed.dart';
part 'thread_type_bloc.g.dart';
part 'thread_type_state.dart';

final _logger = LogService('thread_type_bloc');

class ThreadTypeBloc extends Cubit<ThreadTypeState> {
  ThreadTypeBloc({
    required LocalStorage localStorage,
    required LanguageBloc languageBloc,
  })  :
   _localStorage = localStorage,
   _languageBloc = languageBloc,
        super(ThreadTypeState());

  final LocalStorage _localStorage;
  final LanguageBloc _languageBloc;

  Future<void> load() async {
    emit(state.copyWith(status: EnumStatus.load));
    try {
      final threadTypes = await _fetchThreadTypes();

      if (DateTime.now().millisecondsSinceEpoch % 2 == 0) {
        throw Exception('Error loading thread types');
      }
      emit(state.copyWith(status: EnumStatus.success, threadTypes: threadTypes));
    } on Exception catch (e, s) {
      _logger.e('Error loading thread types', error: e, stackTrace: s);
      _setErrorState();
    }
  }

  Future<void> updateUserSelection(ThreadTypeModel selectedThreadType) async {
    emit(state.copyWith(status: EnumStatus.prepareNavigating));

    await _localStorage.updateUserSelection(
      (current) => current.copyWith(
        threadType: selectedThreadType.enumThreadType,
      ),
    );
    emit(state.copyWith(status: EnumStatus.navigating));
    await Future<void>.delayed(const Duration(seconds: 1));
    emit(state.copyWith(status: EnumStatus.success));
  }

  Future<List<ThreadTypeModel>> _fetchThreadTypes() async {
    return [
      ThreadTypeModel(
        enumThreadType: EnumThreadType.f,
        svgAssetPath: Assets.svg.gaika,
      ),
      ThreadTypeModel(
        enumThreadType: EnumThreadType.m,
        svgAssetPath: Assets.svg.bolt,
      ),
    ];
  }

  void _setErrorState() {
    final currentLang = _languageBloc.state.enumLang;
    final errorMsg = currentLang == EnumLang.en
        ? 'An error occurred while loading thread types.'
        : 'Произошла ошибка при загрузке типов резьбы.';
    emit(state.copyWith(status: EnumStatus.error, errorMsg: errorMsg));
  }

}
