// ignore_for_file: non_constant_identifier_names

import 'dart:core';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:threadfon/core/constants/common.dart';
import 'package:threadfon/core/utils/app_utils.dart';

class MThreadInfoCubit extends Cubit<int> {
  MThreadInfoCubit() : super(ConstCommon.mmUnit);

  void setUnit(int value) {
    emit(value);
  }

  // double _diam = 0;
  // double _pitch = 0;

  String diam(String diam) {
    if (state == ConstCommon.mmUnit) {
      // _diam = AppUtilsParse.stringToDouble(diam);
      return diam;
    } else {
      return AppUtilsNumber.mmToInch(diam);
    }
  }

  String pitch(String pitch) {
    if (state == ConstCommon.mmUnit) {
      // _pitch = AppUtilsParse.stringToDouble(pitch);
      return pitch;
    } else {
      return AppUtilsNumber.mmToInch(pitch);
    }
  }

  String minorMajorDiam({
    required bool isMale,
    required String diameter,
    required String pitch,
  }) =>
      isMale ? diam(diameter) : _minorDiam(diam: diameter, pitch: pitch);

  String minorMajorDiamSub({
    required bool isMale,
    required String diameter,
    required String pitch,
  }) {
    var result = 0.0;

    if (isMale) {
      result = _basicMiniordBolt(diam: diameter, pitch: pitch);
    } else {
      result = AppUtilsParse.stringToDouble(diameter);
    }
    if (state == ConstCommon.inchUnit) {
      return AppUtilsNumber.mmToInch(result.toString());
    }

    return AppUtilsNumber.getFormatNumber(result, ConstCommon.precisionMm);
  }

  String minorMajorDiamToleranceEs({
    required bool isMale,
    required double es_d,
    required double es_d1,
  }) {
    var es = '';

    if (state == ConstCommon.mmUnit && isMale) {
      es = AppUtilsNumber.getFormatNumber(es_d, ConstCommon.precisionMm);
    } else if (state == ConstCommon.mmUnit && !isMale) {
      es = AppUtilsNumber.getFormatNumber(es_d1, ConstCommon.precisionMm);
    } else if (state == ConstCommon.inchUnit && isMale) {
      es = AppUtilsNumber.getFormatNumber(
        es_d / 25.4,
        ConstCommon.precisionInch,
      );
    } else if (state == ConstCommon.inchUnit && !isMale) {
      es = AppUtilsNumber.getFormatNumber(
        es_d1 / 25.4,
        ConstCommon.precisionInch,
      );
    }

    return es;
  }

  String minorMajorDiamToleranceEi({
    required bool isMale,
    required double ei_d,
    required double ei_d1,
  }) {
    var ei = '';

    if (state == ConstCommon.mmUnit && isMale) {
      ei = AppUtilsNumber.getFormatNumber(ei_d, ConstCommon.precisionMm);
    } else if (state == ConstCommon.mmUnit && !isMale) {
      ei = AppUtilsNumber.getFormatNumber(ei_d1, ConstCommon.precisionMm);
    } else if (state == ConstCommon.inchUnit && isMale) {
      ei = AppUtilsNumber.getFormatNumber(
        ei_d / 25.4,
        ConstCommon.precisionInch,
      );
    } else if (state == ConstCommon.inchUnit && !isMale) {
      ei = AppUtilsNumber.getFormatNumber(
        ei_d1 / 25.4,
        ConstCommon.precisionInch,
      );
    }

    return ei;
  }

  // ignore: long-parameter-list
  String minorMajorDiamMinSub({
    required String diamS,
    required String pitch,
    required bool isMale,
    required double ei_d,
    required double ei_d1,
  }) {
    var result = 0.0;
    final diam = AppUtilsParse.stringToDouble(diamS);
    result = isMale
        ? _basicMiniordBolt(diam: diamS, pitch: pitch) + ei_d
        : diam + ei_d1;

    if (state == ConstCommon.inchUnit) {
      return AppUtilsNumber.mmToInch(result.toString());
    }

    return AppUtilsNumber.getFormatNumber(result, ConstCommon.precisionMm);
  }

  // ignore: long-parameter-list
  String minorMajorDiamMaxSub({
    required String diamS,
    required bool isMale,
    required String pitch,
    required double es_d,
    required double es_d1,
  }) {
    var result = 0.0;
    final diam = AppUtilsParse.stringToDouble(diamS);

    final basicMiniorBolt = _basicMiniordBolt(diam: diamS, pitch: pitch);

    if (isMale) {
      result = basicMiniorBolt + es_d;
    } else {
      result = diam + es_d1;
    }

    if (state == ConstCommon.inchUnit) {
      return AppUtilsNumber.mmToInch(result.toString());
    }

    return AppUtilsNumber.getFormatNumber(result, ConstCommon.precisionMm);
  }

  String minorMajorDiamMin({
    required String diam,
    required String pitch,
    required bool isMale,
    required double ei_d,
    required double ei_d1,
  }) {
    var result = 0.0;
    if (isMale) {
      result = AppUtilsParse.stringToDouble(diam) + ei_d;
    } else {
      result = _basicMiniorNuts(diam: diam, pitch: pitch) + ei_d1;
    }

    if (state == ConstCommon.inchUnit) {
      return AppUtilsNumber.mmToInch(result.toString());
    }

    return AppUtilsNumber.getFormatNumber(result, ConstCommon.precisionMm);
  }

  String minorMajorDiamMeanSub({
    required String diamS,
    required String pitch,
    required bool isMale,
    required double ei_d,
    required double ei_d1,
    required double es_d,
    required double es_d1,
  }) {
    var result = 0.0;
    final diam = AppUtilsParse.stringToDouble(diamS);

    final basicMiniorBolt = _basicMiniordBolt(diam: diamS, pitch: pitch);

    if (isMale) {
      result = ((basicMiniorBolt + ei_d) + (basicMiniorBolt + es_d)) / 2;
    } else {
      result = ((diam + ei_d1) + (diam + es_d1)) / 2;
    }

    if (state == ConstCommon.inchUnit) {
      return AppUtilsNumber.mmToInch(result.toString());
    }

    return AppUtilsNumber.getFormatNumber(result, ConstCommon.precisionMm);
  }

  String minorMajorDiamMean({
    required String diamS,
    required String pitch,
    required bool isMale,
    required double ei_d,
    required double ei_d1,
    required double es_d,
    required double es_d1,
  }) {
    var result = 0.0;
    final diam = AppUtilsParse.stringToDouble(diamS);
    final basicMiniorNuts = _basicMiniorNuts(diam: diamS, pitch: pitch);

    if (isMale) {
      result = ((diam + ei_d) + (diam + es_d)) / 2;
    } else {
      result = ((basicMiniorNuts + ei_d1) + (basicMiniorNuts + es_d1)) / 2;
    }

    if (state == ConstCommon.inchUnit) {
      return AppUtilsNumber.mmToInch(result.toString());
    }

    return AppUtilsNumber.getFormatNumber(result, ConstCommon.precisionMm);
  }

  String minorMajorDiamMax({
    required String diamS,
    required bool isMale,
    required String pitch,
    required double es_d,
    required double es_d1,
  }) {
    var result = 0.0;
    final diam = AppUtilsParse.stringToDouble(diamS);
    final basicMiniorNuts = _basicMiniorNuts(diam: diamS, pitch: pitch);

    if (isMale) {
      result = diam + es_d;
    } else {
      result = basicMiniorNuts + es_d1;
    }

    if (state == ConstCommon.inchUnit) {
      return AppUtilsNumber.mmToInch(result.toString());
    }

    return AppUtilsNumber.getFormatNumber(result, ConstCommon.precisionMm);
  }

  //==============middlePich=====================
  String middleDiam({
    required String diam,
    required String pitch,
  }) {
    final result = _midllePitchD2d2(diam: diam, pitch: pitch);

    if (state == ConstCommon.inchUnit) {
      return AppUtilsNumber.mmToInch(result.toString());
    }

    return AppUtilsNumber.getFormatNumber(result, ConstCommon.precisionMm);
  }

  String middleDiamToleranceEi({required double ei_d2}) {
    if (state == ConstCommon.inchUnit) {
      return AppUtilsNumber.mmToInch(ei_d2.toString());
    }

    return AppUtilsNumber.getFormatNumber(ei_d2, ConstCommon.precisionMm);
  }

  String middleDiamToleranceEs({required double es_d2}) {
    if (state == ConstCommon.inchUnit) {
      return AppUtilsNumber.mmToInch(es_d2.toString());
    }

    return AppUtilsNumber.getFormatNumber(es_d2, ConstCommon.precisionMm);
  }

  String middleDiamMin({
    required String diam,
    required String pitch,
    required double ei_d2,
  }) {
    final result = _midllePitchD2d2(diam: diam, pitch: pitch) + ei_d2;

    if (state == ConstCommon.inchUnit) {
      return AppUtilsNumber.mmToInch(result.toString());
    }

    return AppUtilsNumber.getFormatNumber(result, ConstCommon.precisionMm);
  }

  String middleDiamMean({
    required String diam,
    required String pitch,
    required double ei_d2,
    required double es_d2,
  }) {
    final midllePitch = _midllePitchD2d2(diam: diam, pitch: pitch);

    final result = (midllePitch + ei_d2 + midllePitch + es_d2) / 2;
    if (state == ConstCommon.inchUnit) {
      return AppUtilsNumber.mmToInch(result.toString());
    }

    return AppUtilsNumber.getFormatNumber(result, ConstCommon.precisionMm);
  }

  String middleDiamMax({
    required String diam,
    required String pitch,
    required double es_d2,
  }) {
    final midllePitch = _midllePitchD2d2(diam: diam, pitch: pitch);

    final result = midllePitch + es_d2;

    if (state == ConstCommon.inchUnit) {
      return AppUtilsNumber.mmToInch(result.toString());
    }

    return AppUtilsNumber.getFormatNumber(result, ConstCommon.precisionMm);
  }

  String _minorDiam({required String diam, required String pitch}) {
    if (state == ConstCommon.inchUnit) {
      return AppUtilsNumber.mmToInch(
        _basicMiniorNuts(diam: diam, pitch: pitch).toString(),
      );
    } else {
      return AppUtilsNumber.getFormatNumber(
        _basicMiniorNuts(diam: diam, pitch: pitch),
        ConstCommon.precisionMm,
      );
    }
  }

  String depth({
    required bool isMale,
    required String diam,
    required String pitch,
  }) =>
      isMale
          ? _depthThreadMale(diam: diam, pitch: pitch)
          : _depthThreadFemale(diam: diam, pitch: pitch);

  String _depthThreadMale({required String diam, required String pitch}) {
    final depth = (AppUtilsParse.stringToDouble(diam) -
            _basicMiniordBolt(diam: diam, pitch: pitch)) /
        2;
    if (state == ConstCommon.inchUnit) {
      return AppUtilsNumber.mmToInch(depth.toString());
    } else {
      return AppUtilsNumber.getFormatNumber(depth, ConstCommon.precisionMm);
    }
  }

  String _depthThreadFemale({required String diam, required String pitch}) {
    final depth = (AppUtilsParse.stringToDouble(diam) -
            _basicMiniorNuts(diam: diam, pitch: pitch)) /
        2;
    if (state == ConstCommon.inchUnit) {
      return AppUtilsNumber.mmToInch(depth.toString());
    } else {
      return AppUtilsNumber.getFormatNumber(depth, ConstCommon.precisionMm);
    }
  }

  double _basicMiniorNuts({required String diam, required String pitch}) =>
      AppUtilsParse.stringToDouble(diam) -
      1.082531755 * AppUtilsParse.stringToDouble(pitch);

  double _basicMiniordBolt({required String diam, required String pitch}) =>
      AppUtilsParse.stringToDouble(diam) -
      1.226869322 * AppUtilsParse.stringToDouble(pitch);

  double _midllePitchD2d2({required String diam, required String pitch}) =>
      AppUtilsParse.stringToDouble(diam) -
      0.649519053 * AppUtilsParse.stringToDouble(pitch);

  @override
  int? fromJson(Map<String, dynamic> json) => json['units'] as int;

  @override
  Map<String, dynamic>? toJson(int state) => <String, dynamic>{'units': state};
}
