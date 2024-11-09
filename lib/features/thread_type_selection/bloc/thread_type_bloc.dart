import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:threadfon/app/language/language_bloc.dart';
import 'package:threadfon/core/constant/enum_navigation.dart';
import 'package:threadfon/core/constant/enum_status.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/features/thread_type_selection/models/thread_type_model.dart';
import 'package:threadfon/features/thread_type_selection/repositories/thread_type_repository.dart';

part 'thread_type_bloc.freezed.dart';
part 'thread_type_bloc.g.dart';
part 'thread_type_state.dart';

final _logger = LogService('thread_type_bloc');

class ThreadTypeBloc extends Cubit<ThreadTypeState> {
  ThreadTypeBloc({
    required ThreadTypeRepository repository,
    required LocalStorage localStorage,
    required LanguageBloc languageBloc,
  })  : _localStorage = localStorage,
        _repository = repository,
        _languageBloc = languageBloc,
        super(const ThreadTypeState());

  final LocalStorage _localStorage;
  final LanguageBloc _languageBloc;
  final ThreadTypeRepository _repository;

  Future<void> load() async {
    emit(state.copyWith(enumPageStatus: EnumPageStatus.loading));
    try {
      final threadTypes = await _repository.fetchThreadTypes();

      emit(state.copyWith(enumPageStatus: EnumPageStatus.success, threadTypes: threadTypes));
    } on Exception catch (e, s) {
      _logger.e('Error loading thread types', error: e, stackTrace: s);
      _setErrorState();
    }
  }

  Future<void> preparationNavigation(ThreadTypeModel selectedThreadType) async {
    emit(state.copyWith(enumNavigationStatus: EnumNavigationStatus.preparation));
    try {
      await _localStorage.updateUserSelection(
        (current) => current.copyWith(
          threadType: selectedThreadType.enumThreadType,
        ),
      );
      emit(state.copyWith(enumNavigationStatus: EnumNavigationStatus.navigation));
      await Future<void>.delayed(const Duration(milliseconds: 100));
      emit(state.copyWith(enumNavigationStatus: EnumNavigationStatus.initial));
    } catch (e, s) {
      _logger.e('Error updating thread type selection', error: e, stackTrace: s);
      _setErrorState();
    }
  }

  void _setErrorState() {
    final currentLang = _languageBloc.state.enumLang;
    final errorMsg = currentLang == EnumLang.en
        ? 'An error occurred while loading thread types.'
        : 'Произошла ошибка при загрузке типов резьбы.';
    emit(state.copyWith(
        enumPageStatus: EnumPageStatus.error, errorMsg: errorMsg, enumNavigationStatus: EnumNavigationStatus.initial));
  }
}
