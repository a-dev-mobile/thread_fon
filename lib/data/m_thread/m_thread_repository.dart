// ignore_for_file: non_constant_identifier_names, unused_local_variable

// Package imports:
import 'package:sqflite/sqflite.dart';

import 'package:threadfon/core/utils/app_log.dart';
import 'package:threadfon/core/utils/app_utils.dart';
import 'package:threadfon/data/m_thread/models/diam/m_thread_diam_model.dart';
import 'package:threadfon/data/m_thread/models/pitch/m_thread_pitch_model.dart';
import 'package:threadfon/data/m_thread/models/tolerance/m_thread_tolerance_model.dart';
import 'package:threadfon/data/m_thread/models/tolerance_values/m_thread_tolerance_values_model.dart';

class MThreadRepository {
  MThreadRepository({required this.pathDB});
  final String pathDB;

  Future<List<MThreadDiamModel>> fetchMDiams() async {
    final db = await openDatabase(pathDB);
    final List<Map> queryResult = await db.rawQuery(
      '''
 select [Range_1] as diam from  [isoNormal] WHERE diam is NOT NULL
 UNION
 select [Range_2] as diam from [isoNormal] WHERE diam is NOT NULL
 UNION
 select [Range_3] as diam from  [isoNormal] WHERE diam is NOT NULL
 UNION
 select [Range_1] as diam from [isoSmail] WHERE diam is NOT NULL
 UNION
 select [Range_2] as diam from  [isoSmail] WHERE diam is NOT NULL
''',
    );

    await db.close();

    if (queryResult.isEmpty) throw Exception('error fetching mDiams');

    final mDiams = <MThreadDiamModel>[];
    var value = 0.0;
    for (final item in queryResult) {
      value = item['diam'] as double;
      mDiams.add(
        MThreadDiamModel(diam: AppUtilsNumber.getFormatNumber(value, 2)),
      );
    }

    return mDiams;
  }

  Future<MThreadPitchModel> fetchMPitch(String diam) async {
    final db = await openDatabase(pathDB);
    final List<Map> queryPitchCoarseFineResult = await db.rawQuery(
      '''
    select * from [isoNormal]n where n.[Range_1] = $diam or n.[Range_2] = $diam or n.[Range_3] = $diam
''',
    );

    final List<Map> queryPitchSuperFineResult = await db.rawQuery(
      '''
    select * from  [isoSmail]s where s.[Range_1] = $diam or s.[Range_2] = $diam
''',
    );

    await db.close();

    if (queryPitchCoarseFineResult.isEmpty &&
        queryPitchSuperFineResult.isEmpty) {
      throw Exception('error fetching data');
    }

    final pitchsFine = <String>[];
    final pitchsSuperFine = <String>[];
    // String key = '';
    var value = '';

    var pitchModel = MThreadPitchModel();
    //=================================
    // parsing Fine
    if (queryPitchCoarseFineResult.isNotEmpty) {
      for (var i = 5; i < queryPitchCoarseFineResult[0].length; i++) {
        // key = queryPitchCoarseFineResult[0].keys.elementAt(i).toString();
        value = queryPitchCoarseFineResult[0].values.elementAt(i).toString();

        if (value != 'null') {
          pitchsFine.add(value);
          pitchModel = pitchModel.copyWith(isFine: true);
        }
      }

      pitchModel = pitchModel.copyWith(pitchsFine: pitchsFine);
      //=================================
//  parsing coarsePitch
      var coarsePitch = 0.0;
//
      if (queryPitchCoarseFineResult[0]['StandardPitch'] != null) {
        coarsePitch = queryPitchCoarseFineResult[0]['StandardPitch'] as double;

        pitchModel = pitchModel.copyWith(
          isCoarse: true,
          pitchCoarse: AppUtilsNumber.getFormatNumber(coarsePitch, 5),
        );
      }
    }

//=================================
// parsing superFine
    if (queryPitchSuperFineResult.isNotEmpty) {
      for (var i = 3; i < queryPitchSuperFineResult[0].length; i++) {
        // key = queryPitchSuperFineResult[0].keys.elementAt(i).toString();
        value = queryPitchSuperFineResult[0].values.elementAt(i).toString();

        if (value != 'null') {
          pitchsSuperFine.add(value);
          pitchModel = pitchModel.copyWith(isSuperFine: true);
        }
      }
    }

    pitchModel = pitchModel.copyWith(pitchsSuperFine: pitchsSuperFine);

    return pitchModel;
  }

  Future<MThreadToleranceModel> fetchMTolerance({
    required String diam,
    required String pitch,
    required bool isMale,
  }) async {
    MThreadToleranceModel toleranceModel;

    final db = await openDatabase(pathDB);

    final query = '''
   select * from [IsoTolerance]t where t.[Pitch] =  $pitch  and  t.[Diameter]  = ${_typeDiam(diam)}
''';

    final List<Map> queryTolerance = await db.rawQuery(query);

    // print(query);

    await db.close();
    var partTolerance = <String>[];
    final toleranceStringList = <String>[];
    var key = '';
    var value = '';
    var id = '';

    if (queryTolerance.isNotEmpty) {
      id = queryTolerance[0].values.elementAt(0).toString();

      for (var i = 3; i < queryTolerance[0].length; i++) {
        key = queryTolerance[0].keys.elementAt(i).toString();
        value = queryTolerance[0].values.elementAt(i).toString();

        if (value.isEmpty || value == 'null') continue;

        partTolerance = key.split('_');
        if (isMale) {
          if (partTolerance.length > 2 && partTolerance.length <= 3) {
            if (toleranceStringList.contains(partTolerance[2])) continue;
            toleranceStringList.add(partTolerance[2]);
          }
        } else {
          if (partTolerance.length > 3) {
            if (toleranceStringList.contains(partTolerance[2])) continue;
            toleranceStringList.add(partTolerance[2]);
          }
        }
      }
    }
    toleranceStringList.sort();

    toleranceModel =
        MThreadToleranceModel(listTolerance: toleranceStringList, id: id);

    return toleranceModel;
  }

  int _typeDiam(String diam) {
    final nomDiam = double.tryParse(diam) ?? 0;
    if (nomDiam <= 1.4 && nomDiam >= 1) {
      return 1;
    } else if (nomDiam <= 2.8 && nomDiam >= 1.4) {
      return 2;
    } else if (nomDiam <= 5.6 && nomDiam >= 2.8) {
      return 3;
    } else if (nomDiam <= 11.2 && nomDiam >= 5.6) {
      return 4;
    } else if (nomDiam <= 22.4 && nomDiam >= 11.2) {
      return 5;
    } else if (nomDiam <= 45 && nomDiam >= 22.4) {
      return 6;
    } else if (nomDiam <= 90 && nomDiam >= 45) {
      return 7;
    } else if (nomDiam <= 180 && nomDiam >= 90) {
      return 8;
    } else if (nomDiam <= 355 && nomDiam >= 180) {
      return 9;
    } else if (nomDiam <= 600 && nomDiam >= 355) {
      return 10;
    }
    return 0;
  }

  // ignore: long-method
  Future<MThreadToleranceValuesModel> fetchMToleranceValues({
    required String id,
    required String tolerance,
    required bool isMale,
  }) async {
    MThreadToleranceValuesModel toleranceValuesModel;
    final db = await openDatabase(pathDB);

    final query = 'select * from IsoTolerance where _id =  $id ';

    final List<Map> response = await db.rawQuery(query);

    await db.close();

    List<String> partTolerance;
    var key = '';
    var value = '';
    var getEsOrEi = '';
    var es_d = 0.0;
    var ei_d = 0.0;
    var es_d1 = 0.0;
    var ei_d1 = 0.0;
    var es_d2 = 0.0;
    var ei_d2 = 0.0;

    if (response.isEmpty) throw Exception();

    for (var i = 3; i < response[0].length; i++) {
      key = response[0].keys.elementAt(i).toString();
      value = response[0].values.elementAt(i).toString();
      if (value == 'null') continue;

      partTolerance = key.split('_');

      if (partTolerance[2] == tolerance) {
        getEsOrEi = '${partTolerance[0]}_${partTolerance[1]}';

        if (isMale) {
          if (partTolerance.length > 1 && partTolerance.length <= 3) {
            if (getEsOrEi == ('ei_d')) {
              ei_d = _stringToDouble(value) / 1000;
            } else if (getEsOrEi == 'es_d') {
              es_d = _stringToDouble(value) / 1000;
            } else if (getEsOrEi == 'es_d1') {
              es_d1 = _stringToDouble(value) / 1000;
            } else if (getEsOrEi == 'ei_d1') {
              ei_d1 = _stringToDouble(value) / 1000;
            } else if (getEsOrEi == 'ei_d2') {
              ei_d2 = _stringToDouble(value) / 1000;
            } else if (getEsOrEi == 'es_d2') {
              es_d2 = _stringToDouble(value) / 1000;
            }
          }
        } else {
          if (partTolerance.length > 3) {
            if (getEsOrEi == ('ei_d')) {
              ei_d = _stringToDouble(value) / 1000;
            } else if (getEsOrEi == 'es_d') {
              es_d = _stringToDouble(value) / 1000;
            } else if (getEsOrEi == 'es_d1') {
              es_d1 = _stringToDouble(value) / 1000;
            } else if (getEsOrEi == 'ei_d1') {
              ei_d1 = _stringToDouble(value) / 1000;
            } else if (getEsOrEi == 'ei_d2') {
              ei_d2 = _stringToDouble(value) / 1000;
            } else if (getEsOrEi == 'es_d2') {
              es_d2 = _stringToDouble(value) / 1000;
            }
          }
        }
      }
    }
    toleranceValuesModel = MThreadToleranceValuesModel(
      es_d: es_d,
      es_d1: es_d1,
      es_d2: es_d2,
      ei_d: ei_d,
      ei_d1: ei_d1,
      ei_d2: ei_d2,
    );

    return toleranceValuesModel;
  }

  double _stringToDouble(String text) {
    var value = 0.0;
    try {
      value = double.parse(text);
    } catch (e) {
      log.e(e);
    }

    return value;
  }
}
