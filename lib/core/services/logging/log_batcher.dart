import 'dart:async';
import 'dart:convert'; // For jsonEncode
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class LogBatcher {
  static final LogBatcher _instance = LogBatcher._internal();
  factory LogBatcher() => _instance;

  final Map<String, List<Map<String, dynamic>>> _logBuffer = {};
  final int _bufferSize = 10; // Number of logs before sending
  final Duration _flushInterval = Duration(seconds: 5); // Sending interval
  Timer? _timer;
  final Dio _dio = Dio();

  LogBatcher._internal() {
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(_flushInterval, (timer) {
      if (_logBuffer.isNotEmpty) {
        _sendLogs();
      }
    });
  }

  void addLog(Level level, Map<String, dynamic> logData) {
    final levelStr = level.toString().split('.').last.toLowerCase();

    _logBuffer.putIfAbsent(levelStr, () => []).add(logData);

    // Check if any log level buffer exceeds the buffer size
    if (_logBuffer[levelStr]!.length >= _bufferSize) {
      _sendLogs();
    }
  }

  void _sendLogs() async {
    // Подготовка данных в формате Loki
    final lokiPayload = _constructLokiPayload(_logBuffer);

    // Отправка логов в Loki
    try {
      await _dio.post(
        'https://loki.wayofdt.de/loki/api/v1/push',
        data: jsonEncode(lokiPayload),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
    } catch (e) {
      // Handle the error appropriately in your application
      print('Error sending logs to Loki: $e');
    } finally {
      _logBuffer.clear();
    }
  }

  Map<String, dynamic> _constructLokiPayload(Map<String, List<Map<String, dynamic>>> logsByLevel) {
    final streams = logsByLevel.entries.map((entry) {
      final level = entry.key;
      final logs = entry.value;

      return {
        'stream': {
          'app': 'ThreadApp',
          'environment': kReleaseMode ? 'Production' : 'Development',
          'level': level,
        },
        'values': logs.map((log) {
          final timestampStr = log['timestamp'].toString();
          final message = log['message'];
          final properties = log['properties'] ?? {};

          if (properties.isNotEmpty) {
            return [timestampStr, message, properties];
          } else {
            return [timestampStr, message];
          }
        }).toList(),
      };
    }).toList();

    return {'streams': streams};
  }

  void dispose() {
    _timer?.cancel();
  }
}
