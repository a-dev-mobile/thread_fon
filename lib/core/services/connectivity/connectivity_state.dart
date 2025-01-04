// lib/core/connectivity/connectivity_state.dart

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

@immutable
abstract final class ConnectivityState {}

@immutable
final class ConnectivityInitial extends ConnectivityState {}

@immutable
final class ConnectivityOnline extends ConnectivityState {
  final List<ConnectivityResult> connectivityResults;

  ConnectivityOnline(this.connectivityResults);
}

@immutable
final class ConnectivityOffline extends ConnectivityState {}
