import 'dart:async';

import 'package:postgres/postgres.dart';
import 'package:threadfon/src/common/data/user_selection.dart';
import 'package:threadfon/src/common/log/l_setup.dart';
import 'package:threadfon/src/features/02_selection_diameter/database_service.dart';
import 'package:threadfon/src/features/05_info/model/info_model.dart';

final _logger = L('info_repository_impl');

class InfoRepositoryImpl {
  InfoRepositoryImpl({
    required DatabaseService databaseService,
  }) : _databaseService = databaseService;

  final DatabaseService _databaseService;

  Future<List<InfoModel>> fetchInfo(UserSelection userSelection) async {
    final connection = await _databaseService.openConnection();

    // Запуск команды "SET TRANSACTION READ WRITE" и выполнение запроса в фоне

    try {
      final query =
          "SELECT * FROM metric.get_info(${userSelection.id}, '${userSelection.threadType!.name}', '${userSelection.tolerance!}' );";

    
      final result = await _databaseService.fetchResults(connection, query);

      final data = result.map((row) {
        final rowMap = row.toColumnMap();
        return InfoModel.fromJson(rowMap);
      }).toList();

      return data;
    } finally {
    await _runAnalytics(connection, userSelection);
      await _databaseService.closeConnection(connection);
    }
  }

  // Фоновая задача для выполнения SQL-запроса
  Future<void> _runAnalytics(Connection connection, UserSelection userSelection) async {
    // Установить транзакцию на запись
    const setTransactionQuery = "SET TRANSACTION READ WRITE;";
    const backgroundQuery = "$setTransactionQuery SELECT analytics.update_or_insert_thread('M10');";
    try {

      await _databaseService.executeQuery(connection, backgroundQuery);
      _logger.i('Background query executed successfully.', includeStackTrace: false);

      await _databaseService.executeQuery(connection, backgroundQuery);
    } catch (e) {
      // Обработка ошибки, если необходимо
      _logger.e('Error in background task: ', error: e);
    }
  }
}
