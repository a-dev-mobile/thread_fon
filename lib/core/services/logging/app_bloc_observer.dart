
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threadfon/core/services/logging/logger.dart';
final _l = L('app_bloc_observer');
// ignore_for_file:avoid-non-ascii-symbols, avoid-dynamic
class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();
  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    _l.d({
      'bloc': bloc.runtimeType.toString(),
      'event': transition.event,
      'currentState': transition.currentState,
      'nextState': transition.nextState,
    });
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    _l.d({
      'bloc': bloc.runtimeType.toString(),
      'currentState': change.currentState,
      'nextState': change.nextState,
    });
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    _l.i({
      'bloc': bloc.runtimeType.toString(),
      'event': event.toString(),
    });
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    _l.e('Error in ${bloc.runtimeType}', error: error, stackTrace: stackTrace);
  }

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    _l.i('Created ${bloc.runtimeType}');
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    _l.i('Closed ${bloc.runtimeType}');
  }
}
