import 'dart:io' as io;

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:threadfon/src/common/log/log_batcher.dart';

class CustomPrinter extends LogPrinter {
  CustomPrinter(this.className)
      : _prettyPrinterWithStack = PrettyPrinter(
          colors: false,
        ),
        _prettyPrinterWithoutStack = PrettyPrinter(colors: false, methodCount: 0);

  final String className;
  final PrettyPrinter _prettyPrinterWithStack;
  final PrettyPrinter _prettyPrinterWithoutStack;

  @override
  List<String> log(LogEvent event) {
    final printer =
        event.stackTrace != null ? _prettyPrinterWithStack : _prettyPrinterWithoutStack;
    final output = printer.log(event);
    return output.map((line) => '[$className] $line').toList();
  }
}

class L {
  L(String className)
      : _logger = Logger(
          printer: CustomPrinter(className),
        ),
        _className = className;

  final Logger _logger;
  final String _className;

  void _logToLoki(Level level, dynamic message,
      {Object? error, StackTrace? stackTrace, bool includeStackTrace = true}) {
    // In release mode, only log 'error' and 'fatal' levels to Loki
    if (kReleaseMode && level.index < Level.error.index) {
      return;
    }

    final timestamp = DateTime.now();
    final logData = {
      'Timestamp': timestamp.toIso8601String(),
      'Level': level.toString().split('.').last,
      'MessageTemplate': '[$_className] $message',
      'Properties': {
        'Error': error?.toString(),
        'StackTrace':
            includeStackTrace ? (stackTrace ?? StackTrace.current).toString() : null,
        'SourceContext': _className,
       
      },
    };

    LogBatcher().addLog(level, logData);
  }

  void t(dynamic message,
      {Object? error, StackTrace? stackTrace, bool includeStackTrace = true}) {
    _logger.t(
      message,
      error: error,
      stackTrace: includeStackTrace ? (stackTrace ?? StackTrace.current) : null,
    );
    _logToLoki(Level.trace, message,
        error: error, stackTrace: stackTrace, includeStackTrace: includeStackTrace);
  }

  void d(dynamic message,
      {Object? error, StackTrace? stackTrace, bool includeStackTrace = true}) {
    _logger.d(
      message,
      error: error,
      stackTrace: includeStackTrace ? (stackTrace ?? StackTrace.current) : null,
    );
    _logToLoki(Level.debug, message,
        error: error, stackTrace: stackTrace, includeStackTrace: includeStackTrace);
  }

  void i(dynamic message,
      {Object? error, StackTrace? stackTrace, bool includeStackTrace = true}) {
    _logger.i(
      message,
      error: error,
      stackTrace: includeStackTrace ? (stackTrace ?? StackTrace.current) : null,
    );
    _logToLoki(Level.info, message,
        error: error, stackTrace: stackTrace, includeStackTrace: includeStackTrace);
  }

  void w(dynamic message,
      {Object? error, StackTrace? stackTrace, bool includeStackTrace = true}) {
    _logger.w(
      message,
      error: error,
      stackTrace: includeStackTrace ? (stackTrace ?? StackTrace.current) : null,
    );
    _logToLoki(Level.warning, message,
        error: error, stackTrace: stackTrace, includeStackTrace: includeStackTrace);
  }

  void e(dynamic message,
      {Object? error, StackTrace? stackTrace, bool includeStackTrace = true}) {
    _logger.e(
      message,
      error: error,
      stackTrace: includeStackTrace ? (stackTrace ?? StackTrace.current) : null,
    );
    _logToLoki(Level.error, message,
        error: error, stackTrace: stackTrace, includeStackTrace: includeStackTrace);
  }

  void f(dynamic message,
      {Object? error, StackTrace? stackTrace, bool includeStackTrace = true}) {
    _logger.f(
      message,
      error: error,
      stackTrace: includeStackTrace ? (stackTrace ?? StackTrace.current) : null,
    );
    _logToLoki(Level.fatal, message,
        error: error, stackTrace: stackTrace, includeStackTrace: includeStackTrace);
  }
}



