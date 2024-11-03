import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:threadfon/core/constant/enum_screen_status.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/features/thread_type_selection/models/thread_type_model.dart';
import 'package:threadfon/features/thread_type_selection/repositories/thread_type_repository.dart';

part 'thread_type_controller.freezed.dart';
part 'thread_type_controller.g.dart';
part 'thread_type_state.dart';

final _logger = LogService('thread_type_controller');

class ThreadTypeController with ChangeNotifier {
  ThreadTypeController({
    required ThreadTypeRepository repository,
    required LocalStorage localStorage,
  })  : _repository = repository,
        _localStorage = localStorage;

  final ThreadTypeRepository _repository;
  final LocalStorage _localStorage;
  ThreadTypeState _state = const ThreadTypeState();

  bool _isDisposed = false;

  ThreadTypeState get state => _state;

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  Future<void> loadThreadTypes() async {
    _updateState(status: EnumScreenStatus.loading);
    try {
      final threadTypes = await _repository.fetchThreadTypes();
      _updateState(status: EnumScreenStatus.success, threadTypes: threadTypes);
    } on Exception catch (e, s) {
      _logger.e('Error loading thread types', error: e, stackTrace: s);
      _updateState(status: EnumScreenStatus.error, error: e.toString());
    }
  }

  void _updateState({
    EnumScreenStatus? status,
    List<ThreadTypeModel>? threadTypes,
    String? error,
  }) {
    if (_isDisposed) return;

    _state = _state.copyWith(
      threadTypes: threadTypes ?? _state.threadTypes,
      status: status ?? _state.status,
      error: error,
    );
    notifyListeners();
  }

  Future<void> updateUserSelection(ThreadTypeModel selectedThreadType) async {
    _updateState(status: EnumScreenStatus.loadingNavigating);
    try {
      // Update user selection in local storage
      await _localStorage.updateUserSelection(
        (current) => current.copyWith(
          threadType: selectedThreadType.enumThreadType,
        ),
      );
      _updateState(status: EnumScreenStatus.navigating);
      await Future<void>.delayed(const Duration(seconds: 1));
      _updateState(status: EnumScreenStatus.success);
    } on Exception catch (e) {
      _updateState(status: EnumScreenStatus.error, error: e.toString());
    }
  }
}
