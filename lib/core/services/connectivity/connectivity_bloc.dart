// lib/core/connectivity/connectivity_bloc.dart

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'connectivity_event.dart';
import 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final Connectivity _connectivity;
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  ConnectivityBloc({Connectivity? connectivity})
    : _connectivity = connectivity ?? Connectivity(),
      super(ConnectivityInitial()) {
    on<ConnectivityChanged>(_onConnectivityChanged);

    // Подписываемся на изменения подключения
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) {
      add(ConnectivityChanged(results));
    });

    // Проверяем текущее состояние подключения при инициализации
    _initializeConnectivity();
  }

  Future<void> _initializeConnectivity() async {
    try {
      final List<ConnectivityResult> results = await _connectivity
          .checkConnectivity();
      add(ConnectivityChanged(results));
    } catch (e) {
      // В случае ошибки считаем, что подключения нет
      add(
        ConnectivityChanged(const <ConnectivityResult>[
          ConnectivityResult.none,
        ]),
      );
    }
  }

  void _onConnectivityChanged(
    ConnectivityChanged event,
    Emitter<ConnectivityState> emit,
  ) {
    if (event.connectivityResults.contains(ConnectivityResult.none)) {
      emit(ConnectivityOffline());
    } else {
      emit(ConnectivityOnline(event.connectivityResults));
    }
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}
