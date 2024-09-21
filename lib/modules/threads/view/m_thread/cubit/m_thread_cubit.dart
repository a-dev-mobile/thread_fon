// ignore_for_file: non_constant_identifier_names

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:threadfon/modules/threads/view/m_thread/models/models.dart';

class MThreadCubit extends Cubit<MThreadModel> {
  MThreadCubit() : super(const MThreadModel());

  void setMale(bool isMale) {
    emit(state.copyWith(isMale: isMale));
  }

  void setDiam(String diam) {
    emit(state.copyWith(diam: diam));
  }

  void setPitch(String pitch) {
    emit(state.copyWith(pitch: pitch));
  }

  void setTolerance(String tolerance) {
    emit(state.copyWith(tolerance: tolerance));
  }

  void setToleranceValue({
    required double ei_d,
    required double ei_d1,
    required double ei_d2,
    required double es_d,
    required double es_d1,
    required double es_d2,
  }) {
    emit(
      state.copyWith(
        ei_d: ei_d,
        ei_d1: ei_d1,
        ei_d2: ei_d2,
        es_d: es_d,
        es_d1: es_d1,
        es_d2: es_d2,
      ),
    );
  }

  void setIdTolerance(String id) {
    emit(state.copyWith(id: id));
  }

  void setCoarsePith() {
    emit(state.copyWith(isCoarsePitch: true));
    emit(state.copyWith(isFinePitch: false));
    emit(state.copyWith(isSuperFinePitch: false));
  }

  void setFinePith() {
    emit(state.copyWith(isFinePitch: true));
    emit(state.copyWith(isCoarsePitch: false));
    emit(state.copyWith(isSuperFinePitch: false));
  }

  void setSuperFinePith() {
    emit(state.copyWith(isSuperFinePitch: true));
    emit(state.copyWith(isCoarsePitch: false));
    emit(state.copyWith(isFinePitch: false));
  }
}
