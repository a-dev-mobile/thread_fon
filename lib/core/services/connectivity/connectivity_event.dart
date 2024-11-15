// lib/core/connectivity/connectivity_event.dart

import 'package:connectivity_plus/connectivity_plus.dart';

abstract class ConnectivityEvent {}

class ConnectivityChanged extends ConnectivityEvent {
  final List<ConnectivityResult> connectivityResults;

  ConnectivityChanged(this.connectivityResults);
}
