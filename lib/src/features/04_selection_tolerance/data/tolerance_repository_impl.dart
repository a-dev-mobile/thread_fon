import 'dart:async';

import 'package:threadfon/src/common/constant/enums_thread_type.dart';
import 'package:threadfon/src/features/02_selection_diameter/database_service.dart';

import 'package:threadfon/src/features/04_selection_tolerance/model/tolerance_model.dart';

class ToleranceRepositoryImpl {
  ToleranceRepositoryImpl({
    required DatabaseService databaseService,
  }) : _databaseService = databaseService;

  final DatabaseService _databaseService;

  Future<List<ToleranceModel>> fetchTolerances(
      int id, EnumThreadType threadType) async {
    final connection = await _databaseService.openConnection();
    try {
      final query =
          "SELECT * FROM metric.get_tolerance($id, '${threadType.name}');";

      final result = await _databaseService.fetchResults(connection, query);

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
