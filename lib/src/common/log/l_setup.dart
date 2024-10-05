import 'dart:io' as io;
import 'package:logger/logger.dart';

class CustomLogger {
  CustomLogger(String className)
      : _logger = Logger(
          filter: CustomLogFilter(),
          printer: CustomPrinter(className),
          output: CustomOutput(),
        );

  final Logger _logger;

  void t(dynamic message,
      {Object? error, StackTrace? stackTrace, bool includeStackTrace = true}) {
    _logger.t(
      message,
      error: error,
      stackTrace: includeStackTrace ? (stackTrace ?? StackTrace.current) : null,
    );
  }

  void d(dynamic message,
      {Object? error, StackTrace? stackTrace, bool includeStackTrace = true}) {
    _logger.d(
      message,
      error: error,
      stackTrace: includeStackTrace ? (stackTrace ?? StackTrace.current) : null,
    );
  }

  void i(dynamic message,
      {Object? error, StackTrace? stackTrace, bool includeStackTrace = true}) {
    _logger.i(
      message,
      error: error,
      stackTrace: includeStackTrace ? (stackTrace ?? StackTrace.current) : null,
    );
  }

  void w(dynamic message,
      {Object? error, StackTrace? stackTrace, bool includeStackTrace = true}) {
    _logger.w(
      message,
      error: error,
      stackTrace: includeStackTrace ? (stackTrace ?? StackTrace.current) : null,
    );
  }

  void e(dynamic message,
      {Object? error, StackTrace? stackTrace, bool includeStackTrace = true}) {
    _logger.e(
      message,
      error: error,
      stackTrace: includeStackTrace ? (stackTrace ?? StackTrace.current) : null,
    );
    AppErrorHandler().recordError(error ?? message, stackTrace ?? StackTrace.current);
  }

  void f(dynamic message,
      {Object? error, StackTrace? stackTrace, bool includeStackTrace = true}) {
    _logger.f(
      message,
      error: error,
      stackTrace: includeStackTrace ? (stackTrace ?? StackTrace.current) : null,
    );
    AppErrorHandler().recordError(error ?? message, stackTrace ?? StackTrace.current);
  }
}

class CustomPrinter extends LogPrinter {
  CustomPrinter(this.className)
      : _prettyPrinterWithStack = PrettyPrinter(
          methodCount: 2,
          errorMethodCount: 8,
          lineLength: io.stdout.terminalColumns,
          colors: io.stdout.supportsAnsiEscapes,
          printEmojis: true,
          dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
        ),
        _prettyPrinterWithoutStack = PrettyPrinter(
          methodCount: 0,
          lineLength: io.stdout.terminalColumns,
          colors: io.stdout.supportsAnsiEscapes,
          printEmojis: true,
          dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
        );

  final String className;
  final PrettyPrinter _prettyPrinterWithStack;
  final PrettyPrinter _prettyPrinterWithoutStack;

  @override
  List<String> log(LogEvent event) {
    final printer = event.stackTrace != null
        ? _prettyPrinterWithStack
        : _prettyPrinterWithoutStack;
    final output = printer.log(event);
    return output.map((line) => '[$className] $line').toList();
  }
}

class CustomLogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    // Consider adding specific conditions to avoid logging everything in production.
    return event.level.index >= Logger.level.index;
  }
}

class CustomOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    for (final line in event.lines) {
      try {
        io.stdout.writeln(line); // Write to the console output.
      } on Exception catch (e, s) {
        io.stderr.writeln('Failed to write log: $e');
      }
    }
  }
}

class AppErrorHandler {
  Future<void> recordError(dynamic error, StackTrace stackTrace) async {
    // Your implementation for error logging, e.g., sending to Firebase or Sentry.
    io.stderr.writeln('Error recorded: $error');
    io.stderr.writeln('StackTrace: $stackTrace');
  }
}