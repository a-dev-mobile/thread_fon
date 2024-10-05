import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:threadfon/src/common/constant/enum_screen_status.dart'; // Добавьте импорт EnumStatus
import 'package:threadfon/src/common/data/local_storage.dart';
import 'package:threadfon/src/common/error/error_state.dart';
import 'package:threadfon/src/common/log/l_setup.dart';
import 'package:threadfon/src/features/pitch_selection/data/i_pitch_repository.dart';
import 'package:threadfon/src/features/pitch_selection/model/pitch_model.dart';

part 'pitch_controller.freezed.dart';
part 'pitch_state.dart';

final _logger = L('pitch_controller');

class PitchController with ChangeNotifier {
  PitchController({required IPitchRepository repository, required LocalStorage localStorage})
      : _repository = repository,
        _localStorage = localStorage;
  PitchState _state = const PitchState();

  final IPitchRepository _repository;
  final LocalStorage _localStorage;

  bool _isDisposed = false;

  PitchState get state => _state;

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  Future<void> loadPitchs() async {
    _updateState(status: EnumScreenStatus.loading, error: null);

    final userSelection = await _localStorage.getUserSelection();

    try {
      final model = await _repository.fetchPitchs(userSelection.diameter!);
      _updateState(status: EnumScreenStatus.success, model: model);
    } on Exception catch (e, s) {
      _logger.e('Error loading diameters', error: e, stackTrace: s);

      _updateState(
        status: EnumScreenStatus.error,
        error: ErrorState(
          exception: e,
          stackTrace: s.toString().isNotEmpty ? s : StackTrace.current,
          msgUser: 'An error occurred while loading pitchs. Please try again later.',
        ),
      );
    }
  }

  void _updateState({
    EnumScreenStatus? status,
    List<PitchModel>? model,
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

  Future<void> updateUserSelection({required int id, required double diameter}) async {
    _updateState(status: EnumScreenStatus.loadingNavigating);
    try {
      await _localStorage.updateUserSelection((userSelection) => userSelection.copyWith(id: id, diameter: diameter));

      _updateState(status: EnumScreenStatus.navigating);
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
