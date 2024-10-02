import 'package:postgres/postgres.dart';
import 'package:threadfon/src/common/log/l_setup.dart';

final _l = L('database_service');

class DatabaseService {
// Публичный конструктор
  DatabaseService({
    required this.host,
    required this.database,
    required this.username,
    required this.password,
  });
  // Параметры подключения
  final String host;
  final String database;
  final String username;
  final String password;

  /// Метод для открытия нового соединения
  Future<Connection> openConnection() async {
    final endpoint = Endpoint(
      host: host,
      database: database,
      username: username,
      password: password,
    );

    try {
      final connection = await Connection.open(endpoint);
      _l.i('Соединение к базе данных установлено.', includeStackTrace: false);
      return connection;
    } catch (e) {
      _l.e('Ошибка при открытии соединения', error: e);
      rethrow; // Перебрасываем исключение дальше, если нужно
    }
  }

  /// Метод для закрытия соединения
  Future<void> closeConnection(Connection connection) async {
    try {
      await connection.close();
      _l.i('Соединение с базой данных закрыто.', includeStackTrace: false);
    } catch (e) {
      _l.e('Ошибка при закрытии соединения', error: e);
      rethrow; // Перебрасываем исключение дальше, если нужно
    }
  }

  /// Метод для выполнения запроса без возвращаемых данных
  Future<void> execute(Connection connection, String query,
      [Map<String, dynamic>? parameters]) async {
    try {
      await connection.execute(
        Sql.named(query),
        parameters: parameters,
      );
      _l.i('Запрос выполнен успешно.', includeStackTrace: false);
    } catch (e) {
      _l.e('Ошибка при выполнении запроса', error: e);
      rethrow; // Перебрасываем исключение дальше, если нужно
    }
  }

  /// Метод для выполнения запроса и получения результатов
  Future<List<ResultRow>> query(Connection connection, String query,
      [Map<String, dynamic>? parameters]) async {
    try {
      final result = await connection.execute(
        Sql.named(query),
        parameters: parameters,
      );
      _l.i('Запрос выполнен успешно.', includeStackTrace: false);
      return result;
    } catch (e) {
      _l.e('Ошибка при выполнении запроса', error: e);
      rethrow; // Перебрасываем исключение дальше, если нужно
    }
  }

  /// Метод для выполнения транзакции
  Future<void> runTransaction(Connection connection,
      Future<void> Function(TxSession session) action) async {
    try {
      await connection.runTx(action);
      _l.i('Транзакция выполнена успешно.', includeStackTrace: false);
    } catch (e) {
      _l.e('Ошибка при выполнении транзакции', error: e);
      rethrow; // Перебрасываем исключение дальше, если нужно
    }
  }
}
