import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:threadfon/src/common/data/local_storage.dart';
import 'package:threadfon/src/common/log/l_setup.dart';
import 'package:threadfon/src/features/m_thread_diam/data/diameter_repository_impl.dart';
import 'package:threadfon/src/features/m_thread_diam/data/i_diameter_repository.dart';
import 'package:threadfon/src/features/m_thread_diam/enum_page_status.dart'; // Добавьте импорт EnumStatus
import 'package:threadfon/src/features/m_thread_diam/model/diameter_model.dart';

part 'diameter_controller.freezed.dart';
part 'diameter_controller.g.dart';
part 'diameter_state.dart';

final _l = L('diameter_controller');

class DiameterController with ChangeNotifier {
  DiameterController({required DiameterRepositoryImpl repository, required LocalStorage localStorage})
      : _repository = repository,
        _localStorage = localStorage;
  DiameterState _state = const DiameterState();

  final IDiameterRepository _repository;
  final LocalStorage _localStorage;

  bool _isDisposed = false;

  DiameterState get state => _state;

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  Future<void> loadDiameters() async {
    _updateState(
      status: EnumStatus.load,
      error: null,
      diameters: state.diameters,
    );
    try {
      final diameters = await _repository.fetchDiameters();
      _updateState(status: EnumStatus.success, diameters: diameters);
    } catch (e, s) {
      _l.e('error loadDiameters', error: e, stackTrace: s);
      _updateState(
        status: EnumStatus.error,
        error: e.toString(),
        diameters: state.diameters,
      );
    }
  }

  void _updateState({
    required EnumStatus status,
    List<DiameterModel>? diameters,
    String? error,
  }) {
    if (_isDisposed) return;

    _state = _state.copyWith(
      diameters: diameters ?? state.diameters,
      status: status,
      error: error,
    );
    notifyListeners();
  }

  Future<void> updateUserSelection({required int id, required double diam}) async {
    _updateState(status: EnumStatus.transition);
    await Future<void>.delayed(const Duration(seconds: 5));
    await _localStorage.updateUserSelection((userSelection) => userSelection.copyWith(id: id, diam: diam));
    _updateState(status: EnumStatus.navigateToNextScreen);
    _updateState(status: EnumStatus.init);
  }
}
