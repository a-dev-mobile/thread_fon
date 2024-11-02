import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:threadfon/core/constant/enum_screen_status.dart';
import 'package:threadfon/core/models/error_state.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';

import 'package:threadfon/core/services/logging/logger.dart';

import 'package:threadfon/features/04_selection_tolerance/data/tolerance_repository_impl.dart';
import 'package:threadfon/features/04_selection_tolerance/model/tolerance_model.dart';

part 'tolerance_controller.freezed.dart';
part 'tolerance_state.dart';

final _logger = L('tolerance_controller');

class ToleranceController with ChangeNotifier {
  ToleranceController({required ToleranceRepositoryImpl repository, required LocalStorage localStorage})
      : _repository = repository,
        _localStorage = localStorage;
  ToleranceState _state = const ToleranceState();

  final ToleranceRepositoryImpl _repository;
  final LocalStorage _localStorage;

  bool _isDisposed = false;

  ToleranceState get state => _state;

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  Future<void> loadTolerances() async {
    _updateState(status: EnumScreenStatus.loading, error: null);

    final userSelection = await _localStorage.getUserSelection();

    try {
      final model = await _repository.fetchTolerances(userSelection.id!, userSelection.threadType!.name);
      _updateState(status: EnumScreenStatus.success, model: model);
    } on Exception catch (e, s) {
      _logger.e('Error loading diameters', error: e, stackTrace: s);

      _updateState(
        status: EnumScreenStatus.error,
        error: ErrorState(
          exception: e,
          stackTrace: s.toString().isNotEmpty ? s : StackTrace.current,
          msgUser: 'An error occurred while loading tolerances. Please try again later.',
        ),
      );
    }
  }

  void _updateState({
    EnumScreenStatus? status,
    List<ToleranceModel>? model,
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

  Future<void> updateUserSelection({required String tolerance, required String description}) async {
    _updateState(status: EnumScreenStatus.loadingNavigating);
    try {
      await _localStorage
          .updateUserSelection((userSelection) => userSelection.copyWith(tolerance: tolerance, fullName: description));

      _updateState(status: EnumScreenStatus.navigating);
      await Future<void>.delayed(const Duration(seconds: 1));
      _updateState(status: EnumScreenStatus.success);
    } on Exception catch (e, s) {
      _updateState(
        status: EnumScreenStatus.error,
        error: ErrorState(
          exception: e,
          stackTrace: s,
          msgUser: 'An error occurred while updating your selection. Please try again.',
        ),
      );
    }
  }
}
