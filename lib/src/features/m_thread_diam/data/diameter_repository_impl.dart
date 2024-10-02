import 'dart:async';

import 'package:threadfon/src/common/data/local_storage.dart';
import 'package:threadfon/src/features/m_thread_diam/data/i_diameter_repository.dart';
import 'package:threadfon/src/features/m_thread_diam/database_service.dart';
import 'package:threadfon/src/features/m_thread_diam/model/diameter_model.dart';

class DiameterRepositoryImpl implements IDiameterRepository {
  DiameterRepositoryImpl({
    required DatabaseService databaseService,

  }) : _databaseService = databaseService;

  final DatabaseService _databaseService;

  @override
  Future<List<DiameterModel>> fetchDiameters() async {
    final connection = await _databaseService.openConnection();
    try {
      final result = await _databaseService.query(
        connection,
        '''
SELECT DISTINCT ON (diam) id, diam
FROM metric.main
ORDER BY diam ASC;
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
