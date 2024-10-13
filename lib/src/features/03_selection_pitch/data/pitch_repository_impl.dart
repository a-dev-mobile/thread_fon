import 'dart:async';

import 'package:threadfon/src/features/02_selection_diameter/database_service.dart';
import 'package:threadfon/src/features/03_selection_pitch/model/pitch_model.dart';

class PitchRepositoryImpl {
  PitchRepositoryImpl({
    required DatabaseService databaseService,
  }) : _databaseService = databaseService;

  final DatabaseService _databaseService;

  Future<List<PitchModel>> fetchPitchs(double diameter) async {
    final connection = await _databaseService.openConnection();
    try {
      final result = await _databaseService.fetchResults(
          connection, "SELECT * FROM metric.get_pitch($diameter, 'ru');");

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
