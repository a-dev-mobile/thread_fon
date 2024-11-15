import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:threadfon/app/language/language_bloc.dart';
import 'package:threadfon/app/theme/theme_bloc.dart';
import 'package:threadfon/core/constant/enum_navigation.dart';
import 'package:threadfon/core/constant/enum_status.dart';
import 'package:threadfon/core/constant/enum_units.dart';
import 'package:threadfon/core/models/user_selection.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/features/info/models/info_model.dart';
import 'package:threadfon/features/info/repositories/info_repository.dart';

part 'splash_bloc.freezed.dart';
part 'splash_bloc.g.dart';
part 'splash_state.dart';

final _logger = LogService('info_bloc');

class SplashBloc extends Cubit<SplashState> {
  SplashBloc({
    required LanguageBloc languageBloc,
    required LocalStorage storage,
  })  : _storage = storage,
        _languageBloc = languageBloc,
        super(const SplashState());

  final LanguageBloc _languageBloc;
  final LocalStorage _storage;

  Future<void> load() async {
    emit(state.copyWith(enumPageStatus: EnumPageStatus.loading));
    final userSelection = await _storage.getUserSelection();

    try {
      await Future.delayed(Duration(seconds: 5));

   

      await preparationNavigation();
    } catch (e, s) {
      _logger.e('Error loading info', error: e, stackTrace: s);
      _setErrorState();
    }
  }

  Future<void> preparationNavigation() async {
    emit(state.copyWith(enumNavigationStatus: EnumNavigationStatus.preparation));

    try {
      emit(state.copyWith(enumNavigationStatus: EnumNavigationStatus.navigation));
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
        enumPageStatus: EnumPageStatus.error, errorMsg: errorMsg, enumNavigationStatus: EnumNavigationStatus.initial));
  }
}
