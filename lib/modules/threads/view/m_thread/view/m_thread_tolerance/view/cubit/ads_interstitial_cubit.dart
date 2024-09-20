// Package imports:
import 'package:hydrated_bloc/hydrated_bloc.dart';

class AdsInterstitialCubit extends HydratedCubit<int> {
  AdsInterstitialCubit() : super(0);

  @override
  int fromJson(Map<String, dynamic> json) => json['ads'] as int;

  @override
  Map<String, dynamic>? toJson(int state) => <String, dynamic>{'ads': state};

  void increment() {
    emit(state + 1);
  }

  void reset() {
    emit(0);
  }
}
