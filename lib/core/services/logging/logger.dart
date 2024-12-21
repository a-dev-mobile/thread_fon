import 'package:logger/logger.dart';
import 'package:threadfon/core/services/error_reporting/error_reporting_service.dart';

class CustomPrinter extends LogPrinter {
  CustomPrinter(this.fileName)
      : _prettyPrinterWithStack = PrettyPrinter(
          colors: false,
        ),
        _prettyPrinterWithoutStack =
            PrettyPrinter(colors: false, methodCount: 0);

  final String fileName;
  final PrettyPrinter _prettyPrinterWithStack;
  final PrettyPrinter _prettyPrinterWithoutStack;

  @override
  List<String> log(LogEvent event) {
    final printer = event.stackTrace != null
        ? _prettyPrinterWithStack
        : _prettyPrinterWithoutStack;
    final output = printer.log(event);
    return output.map((line) => '[$fileName] $line').toList();
  }
}

class LogService {
  LogService(String fileName)
      : _logger = Logger(
          printer: CustomPrinter(fileName),
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
      {Object? error,
      StackTrace? stackTrace,
      bool includeStackTrace = true,
      Map<String, dynamic>? additionalInfo,
      bool reportToServer = true}) {
    _logger.e(
      message,
      error: error,
      stackTrace: includeStackTrace ? (stackTrace ?? StackTrace.current) : null,
    );
    
    if (reportToServer) {
      globalErrorReporting.reportError(
        error: error ?? message,
        stackTrace: stackTrace ?? StackTrace.current,
        customMessage: message?.toString(),
        additionalInfo: additionalInfo,
      );
    }
  }

  void f(dynamic message,
      {Object? error, StackTrace? stackTrace, bool includeStackTrace = true}) {
    _logger.f(
      message,
      error: error,
      stackTrace: includeStackTrace ? (stackTrace ?? StackTrace.current) : null,
    );
  }
}
