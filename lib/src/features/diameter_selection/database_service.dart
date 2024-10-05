import 'package:postgres/postgres.dart';
import 'package:threadfon/src/common/log/l_setup.dart';

final _logger = L('database_service');

class DatabaseService {
  DatabaseService({
    required this.host,
    required this.database,
    required this.username,
    required this.password,
  });

  final String host;
  final String database;
  final String username;
  final String password;

  Future<Connection> openConnection() async {
    final endpoint = Endpoint(
      host: host,
      database: database,
      username: username,
      password: password,
    );

    try {
      final connection = await Connection.open(endpoint);
      _logger.i('Database connection established.', includeStackTrace: false);
      return connection;
    } on Exception catch (e) {
      _logger.e('Error opening connection', error: e);
      rethrow;
    }
  }

  Future<void> closeConnection(Connection connection) async {
    try {
      await connection.close();
      _logger.i('Database connection closed.', includeStackTrace: false);
    } on Exception catch (e) {
      _logger.e('Error closing connection', error: e);
      rethrow;
    }
  }

  Future<void> executeQuery(Connection connection, String query, [Map<String, dynamic>? parameters]) async {
    try {
      await connection.execute(
        Sql.named(query),
        parameters: parameters,
      );
      _logger.i('Query executed successfully.', includeStackTrace: false);
    } on Exception catch (e) {
      _logger.e('Error executing query', error: e);
      rethrow;
    }
  }

  Future<List<ResultRow>> fetchResults(Connection connection, String query, [Map<String, dynamic>? parameters]) async {
    try {
      final result = await connection.execute(
        Sql.named(query),
        parameters: parameters,
      );
      _logger.i('Query executed successfully.', includeStackTrace: false);
      return result;
    } on Exception catch (e) {
      _logger.e('Error fetching results', error: e);
      rethrow;
    }
  }

  Future<void> runTransaction(Connection connection, Future<void> Function(TxSession session) action) async {
    try {
      await connection.runTx(action);
      _logger.i('Transaction completed successfully.', includeStackTrace: false);
    } on Exception catch (e) {
      _logger.e('Error during transaction', error: e);
      rethrow;
    }
  }
}
