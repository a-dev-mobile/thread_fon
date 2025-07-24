import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:threadfon/app/language/language_bloc.dart';
import 'package:threadfon/core/constant/enum_lang.dart';
import 'package:threadfon/core/constant/enum_navigation_status.dart';
import 'package:threadfon/core/constant/enum_status.dart';
import 'package:threadfon/core/mixins/bloc_ignore_emit_after_closed.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';
import 'package:threadfon/core/services/logging/logger.dart';

part 'splash_bloc.freezed.dart';
part 'splash_bloc.g.dart';
part 'splash_state.dart';

final LogService _logger = LogService('info_bloc');

class SplashBloc extends Cubit<SplashState>
    with BlocIgnoreEmitAfterClosed<SplashState> {
  SplashBloc({
    required LanguageBloc languageBloc,
    required LocalStorage storage,
  }) : _languageBloc = languageBloc,
       super(const SplashState());

  final LanguageBloc _languageBloc;

  Future<void> load() async {
    emit(state.copyWith(enumPageStatus: EnumStatus.loading));

    try {
      await Future<void>.delayed(const Duration(seconds: 1));

      await preparationNavigation();
    } catch (e, s) {
      _logger.e('Error loading info', error: e, stackTrace: s);

      _setErrorState();
    }
  }

  Future<void> preparationNavigation() async {
    try {
      emit(
        state.copyWith(enumNavigationStatus: EnumNavigationStatus.navigation),
      );
    } catch (e, s) {
      _logger.e('Error updating selection', error: e, stackTrace: s);

      _setErrorState();
    }
  }

  void _setErrorState() {
    final EnumLang currentLang = _languageBloc.state.enumLang;
    final String errorMsg = currentLang == EnumLang.en
        ? 'An error occurred while loading info.'
        : 'Произошла ошибка при загрузке информации.';
    emit(
      state.copyWith(
        enumPageStatus: EnumStatus.error,
        errorMsg: errorMsg,
        enumNavigationStatus: EnumNavigationStatus.initial,
      ),
    );
  }
}
