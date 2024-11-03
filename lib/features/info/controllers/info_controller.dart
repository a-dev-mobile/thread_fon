import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:threadfon/core/constant/enum_screen_status.dart';
import 'package:threadfon/core/models/error_state.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/features/info/models/info_model.dart';
import 'package:threadfon/features/info/repositories/info_repository.dart';

part 'info_controller.freezed.dart';
part 'info_state.dart';

final _l = L('info_controller');

class InfoController with ChangeNotifier {
  InfoController({required InfoRepository repository, required LocalStorage localStorage})
      : _repository = repository,
        _localStorage = localStorage;
  InfoState _state = const InfoState();

  final InfoRepository _repository;
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
      final model = await _repository.fetchInfo(
        diameter: userSelection.diameter!,
        pitch: userSelection.pitch!,
        threadType: userSelection.threadType!.name,
        tolerance: userSelection.tolerance!,
      );
      final svgData = await _repository.fetchSvgData(
        diameter: userSelection.diameter!,
        pitch: userSelection.pitch!,
        threadType: userSelection.threadType!.name,
        tolerance: userSelection.tolerance!,
      );
      _updateState(status: EnumScreenStatus.success, model: model, svgData: svgData);
    } on Exception catch (e, s) {
      _l.e('Error loading info', error: e, stackTrace: s);

      _updateState(
        status: EnumScreenStatus.error,
        error: ErrorState(
          exception: e,
          stackTrace: s.toString().isNotEmpty ? s : StackTrace.current,
          msgUser: 'An error occurred while loading info. Please try again later.',
        ),
      );
    }
  }

  void _updateState({
    EnumScreenStatus? status,
    List<InfoModel>? model,
    ErrorState? error,
    String? svgData,
  }) {
    if (_isDisposed) return;

    _state = _state.copyWith(
      model: model ?? _state.model,
      status: status ?? _state.status,
      error: error ?? _state.error,
      svgData: svgData ?? _state.svgData,
    );
    notifyListeners();
  }

  Future<void> updateUserSelection(
    InfoModel data,
  ) async {
    _updateState(status: EnumScreenStatus.loadingNavigating);
    try {
      await _localStorage.updateUserSelection((userSelection) => userSelection.copyWith(
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
          msgUser: 'An error occurred while updating your selection. Please try again.',
        ),
      );
    }
  }
}
