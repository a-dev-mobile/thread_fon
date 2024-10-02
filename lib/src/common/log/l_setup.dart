import 'package:logger/logger.dart';

class CustomPrinter extends LogPrinter {
  CustomPrinter(this.className)
      : _prettyPrinterWithStack = PrettyPrinter(),
        _prettyPrinterWithoutStack = PrettyPrinter(methodCount: 0);
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

class L {
  L(String className)
      : _logger = Logger(
          printer: CustomPrinter(className),
        );

  final Logger _logger;

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
  }

  void t(dynamic message,
      {Object? error, StackTrace? stackTrace, bool includeStackTrace = true}) {
    _logger.t(
      message,
      error: error,
      stackTrace: includeStackTrace ? (stackTrace ?? StackTrace.current) : null,
    );
  }
}
