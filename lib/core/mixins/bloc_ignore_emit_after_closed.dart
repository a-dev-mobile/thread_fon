import 'package:flutter_bloc/flutter_bloc.dart';

mixin BlocIgnoreEmitAfterClosed<State> on Cubit<State> {
  @override
  void emit(State state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
