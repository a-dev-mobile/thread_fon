import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:threadfon/core/constant/enum_screen_status.dart'; // Добавьте импорт EnumStatus
import 'package:threadfon/core/services/local_storage/local_storage.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/features/diameter_selection/models/diameter_model.dart';
import 'package:threadfon/features/diameter_selection/repositories/diameter_repository.dart';

part 'diameter_controller.freezed.dart';
part 'diameter_controller.g.dart';
part 'diameter_state.dart';

final _logger = L('diameter_controller');

class DiameterController with ChangeNotifier {
  DiameterController({required DiameterRepository repository, required LocalStorage localStorage})
      : _repository = repository,
        _localStorage = localStorage;
  DiameterState _state = const DiameterState();

  final DiameterRepository _repository;
  final LocalStorage _localStorage;

  bool _isDisposed = false;

  DiameterState get state => _state;

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  Future<void> loadData() async {
    _updateState(status: EnumScreenStatus.loading, error: null);
    try {
      final diameters = await _repository.fetchDiameters();
      _updateState(status: EnumScreenStatus.success, diameters: diameters);
    } on Exception catch (e, s) {
      _logger.e('Error loading diameters', error: e, stackTrace: s);
      _updateState(status: EnumScreenStatus.error, error: e.toString());
    }
  }

  void _updateState({
    EnumScreenStatus? status,
    List<DiameterModel>? diameters,
    String? error,
  }) {
    if (_isDisposed) return;

    _state = _state.copyWith(
      diameters: diameters ?? _state.diameters,
      status: status ?? _state.status,
      error: error,
    );
    notifyListeners();
  }

  Future<void> updateUserSelection({required int id, required double diameter}) async {
    _updateState(status: EnumScreenStatus.loadingNavigating);
    try {
      await _localStorage.updateUserSelection((userSelection) => userSelection.copyWith(id: id, diameter: diameter));

      _updateState(status: EnumScreenStatus.navigating);

      await Future<void>.delayed(const Duration(seconds: 1));
      _updateState(status: EnumScreenStatus.success);
    } on Exception catch (e) {
      _updateState(status: EnumScreenStatus.error, error: e.toString());
    }
  }
}
