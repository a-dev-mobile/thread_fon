import 'dart:async';

import 'package:threadfon/src/common/constant/enums_thread_type.dart';
import 'package:threadfon/src/features/02_selection_diameter/database_service.dart';
import 'package:threadfon/src/features/05_info/model/info_model.dart';

class InfoRepositoryImpl {
  InfoRepositoryImpl({
    required DatabaseService databaseService,
  }) : _databaseService = databaseService;

  final DatabaseService _databaseService;

  Future<List<InfoModel>> fetchInfo(int id, EnumThreadType threadType) async {
    final connection = await _databaseService.openConnection();
    try {
      final query = "SELECT * FROM metric.get_info($id, '${threadType.name}');";

      final result = await _databaseService.fetchResults(connection, query);

      final data = result.map((row) {
        final rowMap = row.toColumnMap();
        return InfoModel.fromJson(rowMap);
      }).toList();

      return data;
    } finally {
      await _databaseService.closeConnection(connection);
    }
  }
}
