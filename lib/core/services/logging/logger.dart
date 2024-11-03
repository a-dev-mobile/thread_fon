import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:threadfon/core/services/logging/log_batcher.dart';

class CustomPrinter extends LogPrinter {
  CustomPrinter(this.fileName)
      : _prettyPrinterWithStack = PrettyPrinter(
          colors: false,
        ),
        _prettyPrinterWithoutStack = PrettyPrinter(colors: false, methodCount: 0);

  final String fileName;
  final PrettyPrinter _prettyPrinterWithStack;
  final PrettyPrinter _prettyPrinterWithoutStack;

  @override
  List<String> log(LogEvent event) {
    final printer = event.stackTrace != null ? _prettyPrinterWithStack : _prettyPrinterWithoutStack;
    final output = printer.log(event);
    return output.map((line) => '[$fileName] $line').toList();
  }
}

class L {
  L(String fileName)
      : _l = Logger(
          printer: CustomPrinter(fileName),
        ),
        _fileName = fileName;

  final Logger _l;
  final String _fileName;

  void _logToLoki(Level level, dynamic message,
      {Object? error, StackTrace? stackTrace, bool includeStackTrace = true}) {
    // In release mode, only log 'error' and 'fatal' levels to Loki
    if (kReleaseMode && level.index < Level.error.index) {
      return;
    }

    final timestamp = DateTime.now().microsecondsSinceEpoch * 1000; // nanoseconds
    final logData = {
      'timestamp': timestamp,
      'level': level.toString().split('.').last,
      'message': message,
      'properties': {
        if (error != null) 'error': error.toString(),
        if (includeStackTrace && stackTrace != null) 'stackTrace': stackTrace.toString(),
        'file': _fileName,
      },
    };

    LogBatcher().addLog(level, logData);
  }

  void t(dynamic message, {Object? error, StackTrace? stackTrace, bool includeStackTrace = true}) {
    _l.t(
      message,
      error: error,
      stackTrace: includeStackTrace ? (stackTrace ?? StackTrace.current) : null,
    );
    _logToLoki(Level.trace, message, error: error, stackTrace: stackTrace, includeStackTrace: includeStackTrace);
  }

  void d(dynamic message, {Object? error, StackTrace? stackTrace, bool includeStackTrace = true}) {
    _l.d(
      message,
      error: error,
      stackTrace: includeStackTrace ? (stackTrace ?? StackTrace.current) : null,
    );
    _logToLoki(Level.debug, message, error: error, stackTrace: stackTrace, includeStackTrace: includeStackTrace);
  }

  void i(dynamic message, {Object? error, StackTrace? stackTrace, bool includeStackTrace = true}) {
    _l.i(
      message,
      error: error,
      stackTrace: includeStackTrace ? (stackTrace ?? StackTrace.current) : null,
    );
    _logToLoki(Level.info, message, error: error, stackTrace: stackTrace, includeStackTrace: includeStackTrace);
  }

  void w(dynamic message, {Object? error, StackTrace? stackTrace, bool includeStackTrace = true}) {
    _l.w(
      message,
      error: error,
      stackTrace: includeStackTrace ? (stackTrace ?? StackTrace.current) : null,
    );
    _logToLoki(Level.warning, message, error: error, stackTrace: stackTrace, includeStackTrace: includeStackTrace);
  }

  void e(dynamic message, {Object? error, StackTrace? stackTrace, bool includeStackTrace = true}) {
    _l.e(
      message,
      error: error,
      stackTrace: includeStackTrace ? (stackTrace ?? StackTrace.current) : null,
    );
    _logToLoki(Level.error, message, error: error, stackTrace: stackTrace, includeStackTrace: includeStackTrace);
  }

  void f(dynamic message, {Object? error, StackTrace? stackTrace, bool includeStackTrace = true}) {
    _l.f(
      message,
      error: error,
      stackTrace: includeStackTrace ? (stackTrace ?? StackTrace.current) : null,
    );
    _logToLoki(Level.fatal, message, error: error, stackTrace: stackTrace, includeStackTrace: includeStackTrace);
  }
}
