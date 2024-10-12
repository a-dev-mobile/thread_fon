import 'dart:async';

import 'package:threadfon/src/features/selection_2_diameter/data/i_diameter_repository.dart';
import 'package:threadfon/src/features/selection_2_diameter/database_service.dart';
import 'package:threadfon/src/features/selection_2_diameter/model/diameter_model.dart';

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
        "SELECT * FROM metric.get_diameters('ASC');",
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
