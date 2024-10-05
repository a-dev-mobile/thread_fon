import 'dart:async';


import 'package:threadfon/src/features/diameter_selection/database_service.dart';

import 'package:threadfon/src/features/tolerance_selection/data/i_tolerance_repository.dart';
import 'package:threadfon/src/features/tolerance_selection/model/tolerance_model.dart';

class ToleranceRepositoryImpl implements IToleranceRepository {
  ToleranceRepositoryImpl({
    required DatabaseService databaseService,
  }) : _databaseService = databaseService;

  final DatabaseService _databaseService;

  @override
  Future<List<ToleranceModel>> fetchTolerances(double diameter) async {
    final connection = await _databaseService.openConnection();
    try {
      final result = await _databaseService.fetchResults(
        connection,
        '''
SELECT id, diameter, pitch, type_pitch, range_main, range_sub
FROM metric.main
WHERE diameter = $diameter;
''',
      );

      final data = result.map((row) {
        final rowMap = row.toColumnMap();
        return ToleranceModel.fromJson(rowMap);
      }).toList();

      return data;
    } finally {
      await _databaseService.closeConnection(connection);
    }
  }
}
