import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threadfon/core/services/logging/logger.dart';

final _logger = LogService('app_bloc_observer');

// ignore_for_file:avoid-non-ascii-symbols, avoid-dynamic
class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();
  String _truncate(Object? obj, {int maxLength = 1000}) {
    final str = obj?.toString() ?? 'null';
    if (str.length > maxLength) {
      return '${str.substring(0, maxLength)}... [truncated]';
    }
    return str;
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    _logger.d(
        "'bloc': ${bloc.runtimeType}, 'event': ${_truncate(transition.event)}, 'currentState': ${_truncate(transition.currentState)}, 'nextState': ${_truncate(transition.nextState)}");
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    _logger.d(
        "'bloc': ${bloc.runtimeType}, 'currentState': ${_truncate(change.currentState)}, 'nextState': ${_truncate(change.nextState)}");
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    _logger.i("'bloc': ${bloc.runtimeType}, 'event': ${_truncate(event)}");
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    _logger.e('Error in ${bloc.runtimeType}',
        error: error, stackTrace: stackTrace);
  }

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    _logger.i('Created ${bloc.runtimeType}');
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    _logger.i('Closed ${bloc.runtimeType}');
  }
}
