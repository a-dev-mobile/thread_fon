// lib/services/database_service.dart
import 'package:postgres/postgres.dart';

class DatabaseService {
  // Приватный конструктор
  DatabaseService._internal({
    required this.host,
    required this.database,
    required this.username,
    required this.password,
  });


  /// Метод для получения экземпляра синглтона
  static DatabaseService getInstance(

  ) {
    _instance ??= DatabaseService._internal(
      host: '134.255.232.136',
      database: 'thread_db',
      username: 'readonly_user',
      password: '123123',
    );
    return _instance!;
  }
  // Статическая переменная для хранения экземпляра синглтона
  static DatabaseService? _instance;

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
      print('Соединение к базе данных установлено.');
      return connection;
    } catch (e) {
      print('Ошибка при открытии соединения: $e');
      rethrow; // Перебрасываем исключение дальше, если нужно
    }
  }

  /// Метод для закрытия соединения
  Future<void> closeConnection(Connection connection) async {
    try {
      await connection.close();
      print('Соединение с базой данных закрыто.');
    } catch (e) {
      print('Ошибка при закрытии соединения: $e');
      rethrow; // Перебрасываем исключение дальше, если нужно
    }
  }

  /// Метод для выполнения запроса без возвращаемых данных
  Future<void> execute(Connection connection, String query, [Map<String, dynamic>? parameters]) async {
    try {
      await connection.execute(
        Sql.named(query),
        parameters: parameters,
      );
      print('Запрос выполнен успешно.');
    } catch (e) {
      print('Ошибка при выполнении запроса: $e');
      rethrow; // Перебрасываем исключение дальше, если нужно
    }
  }

  /// Метод для выполнения запроса и получения результатов
  Future<List<ResultRow>> query(Connection connection, String query, [Map<String, dynamic>? parameters]) async {
    try {
      final result = await connection.execute(
        Sql.named(query),
        parameters: parameters,
      );
      print('Запрос выполнен успешно.');
      return result;
    } catch (e) {
      print('Ошибка при выполнении запроса: $e');
      rethrow; // Перебрасываем исключение дальше, если нужно
    }
  }

  /// Метод для выполнения транзакции
  Future<void> runTransaction(Connection connection, Future<void> Function(TxSession session) action) async {
    try {
      await connection.runTx(action);
      print('Транзакция выполнена успешно.');
    } catch (e) {
      print('Ошибка при выполнении транзакции: $e');
      rethrow; // Перебрасываем исключение дальше, если нужно
    }
  }
}
