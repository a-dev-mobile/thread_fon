import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:threadfon/src/common/constant/enum_screen_status.dart';
import 'package:threadfon/src/common/data/local_storage.dart';
import 'package:threadfon/src/common/error/error_state.dart';
import 'package:threadfon/src/common/log/l_setup.dart';
import 'package:threadfon/src/features/05_info/data/info_repository_impl.dart';
import 'package:threadfon/src/features/05_info/model/info_model.dart';

part 'info_controller.freezed.dart';
part 'info_state.dart';

final _logger = L('info_controller');

class InfoController with ChangeNotifier {
  InfoController(
      {required InfoRepositoryImpl repository,
      required LocalStorage localStorage})
      : _repository = repository,
        _localStorage = localStorage;
  InfoState _state = const InfoState();

  final InfoRepositoryImpl _repository;
  final LocalStorage _localStorage;

  bool _isDisposed = false;

  InfoState get state => _state;

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  Future<void> load() async {
    _updateState(status: EnumScreenStatus.loading, error: null);

    final userSelection = await _localStorage.getUserSelection();

    try {
      final model = await _repository.fetchInfo(userSelection);
      _updateState(status: EnumScreenStatus.success, model: model);
    } on Exception catch (e, s) {
      _logger.e('Error loading diameters', error: e, stackTrace: s);

      _updateState(
        status: EnumScreenStatus.error,
        error: ErrorState(
          exception: e,
          stackTrace: s.toString().isNotEmpty ? s : StackTrace.current,
          msgUser:
              'An error occurred while loading infos. Please try again later.',
        ),
      );
    }
  }

  void _updateState({
    EnumScreenStatus? status,
    List<InfoModel>? model,
    ErrorState? error,
  }) {
    if (_isDisposed) return;

    _state = _state.copyWith(
      model: model ?? _state.model,
      status: status ?? _state.status,
      error: error ?? _state.error,
    );
    notifyListeners();
  }

  Future<void> updateUserSelection(InfoModel data, 
      ) async {
    _updateState(status: EnumScreenStatus.loadingNavigating);
    try {
      await _localStorage
          .updateUserSelection((userSelection) => userSelection.copyWith(
                id: data.id,
              ));

      _updateState(status: EnumScreenStatus.navigating);
      await Future<void>.delayed(const Duration(seconds: 1));
      _updateState(status: EnumScreenStatus.success);
    } on Exception catch (e, s) {
      _updateState(
        status: EnumScreenStatus.error,
        error: ErrorState(
          exception: e,
          stackTrace: s,
          msgUser:
              'An error occurred while updating your selection. Please try again.',
        ),
      );
    }
  }
}
