import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:threadfon/app/language/language_bloc.dart';
import 'package:threadfon/core/constant/enum_navigation.dart';
import 'package:threadfon/core/constant/enum_status.dart';
import 'package:threadfon/core/mixins/bloc_ignore_emit_after_closed.dart';
import 'package:threadfon/core/services/error_reporting/error_reporting_service.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';
import 'package:threadfon/core/services/logging/logger.dart';

part 'splash_bloc.freezed.dart';
part 'splash_bloc.g.dart';
part 'splash_state.dart';

final _logger = LogService('info_bloc');

class SplashBloc extends Cubit<SplashState> with BlocIgnoreEmitAfterClosed {
  SplashBloc({
    required LanguageBloc languageBloc,
    required LocalStorage storage,
  })  : _languageBloc = languageBloc,
        super(const SplashState());

  final LanguageBloc _languageBloc;

  Future<void> load() async {
    emit(state.copyWith(enumPageStatus: EnumStatus.loading));

    try {
      await Future.delayed(Duration(seconds: 1));

      await preparationNavigation();
    } catch (e, s) {
      _logger.e('Error loading info', error: e, stackTrace: s);
    
      _setErrorState();
    }
  }

  Future<void> preparationNavigation() async {
    try {
      emit(state.copyWith(
          enumNavigationStatus: EnumNavigationStatus.navigation));
    } catch (e, s) {
      _logger.e('Error updating selection', error: e, stackTrace: s);
    
      _setErrorState();
    }
  }

  void _setErrorState() {
    final currentLang = _languageBloc.state.enumLang;
    final errorMsg = currentLang == EnumLang.en
        ? 'An error occurred while loading info.'
        : 'Произошла ошибка при загрузке информации.';
    emit(state.copyWith(
        enumPageStatus: EnumStatus.error,
        errorMsg: errorMsg,
        enumNavigationStatus: EnumNavigationStatus.initial));
  }
}
