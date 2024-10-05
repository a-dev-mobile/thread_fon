import 'dart:async';

import 'package:threadfon/src/features/diameter_selection/database_service.dart';
import 'package:threadfon/src/features/pitch_selection/data/i_pitch_repository.dart';
import 'package:threadfon/src/features/pitch_selection/model/pitch_model.dart';

class PitchRepositoryImpl implements IPitchRepository {
  PitchRepositoryImpl({
    required DatabaseService databaseService,
  }) : _databaseService = databaseService;

  final DatabaseService _databaseService;

  @override
  Future<List<PitchModel>> fetchPitchs(double diameter) async {
    final connection = await _databaseService.openConnection();
    try {
      final result = await _databaseService.fetchResults(
        connection,
        '''
SELECT id, diameter, pitch, type_pitch, range_main, range_sub
FROM metric.main
WHERE diameter = $diameter
ORDER BY pitch DESC;

''',
      );

      final data = result.map((row) {
        final rowMap = row.toColumnMap();
        return PitchModel.fromJson(rowMap);
      }).toList();

      return data;
    } finally {
      await _databaseService.closeConnection(connection);
    }
  }
}
