// lib/core/connectivity/connectivity_state.dart

import 'package:connectivity_plus/connectivity_plus.dart';

abstract class ConnectivityState {}

class ConnectivityInitial extends ConnectivityState {}

class ConnectivityOnline extends ConnectivityState {
  final List<ConnectivityResult> connectivityResults;

  ConnectivityOnline(this.connectivityResults);
}

class ConnectivityOffline extends ConnectivityState {}
