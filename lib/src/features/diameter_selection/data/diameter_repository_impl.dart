import 'dart:async';

import 'package:threadfon/src/common/data/local_storage.dart';
import 'package:threadfon/src/features/diameter_selection/data/i_diameter_repository.dart';
import 'package:threadfon/src/features/diameter_selection/database_service.dart';
import 'package:threadfon/src/features/diameter_selection/model/diameter_model.dart';

class DiameterRepositoryImpl implements IDiameterRepository {
  DiameterRepositoryImpl({
    required DatabaseService databaseService,

  }) : _databaseService = databaseService;

  final DatabaseService _databaseService;

  @override
  Future<List<DiameterModel>> fetchDiameters() async {
    final connection = await _databaseService.openConnection();
    try {
      final result = await _databaseService.fetchResults(
        connection,
        '''
SELECT DISTINCT ON (diameter) id, diameter
FROM metric.main
ORDER BY diameter ASC;
''',
      );

      final diameters = result.map((row) {
        final rowMap = row.toColumnMap();
        return DiameterModel.fromJson(rowMap);
      }).toList();

      return diameters;
    } finally {
      await _databaseService.closeConnection(connection);
    }
  }
}
