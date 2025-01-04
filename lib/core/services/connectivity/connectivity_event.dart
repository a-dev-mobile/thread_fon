// lib/core/connectivity/connectivity_event.dart

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

@immutable
abstract final class ConnectivityEvent {}

@immutable
final class ConnectivityChanged extends ConnectivityEvent {
  final List<ConnectivityResult> connectivityResults;

  ConnectivityChanged(this.connectivityResults);
}
