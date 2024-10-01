import 'package:logger/logger.dart';

class CustomPrinter extends LogPrinter {

  CustomPrinter(this.className, this.original);
  final String className;
  final LogPrinter original;

  @override
  List<String> log(LogEvent event) {
    var output = original.log(event);
    return output.map((line) => '[$className] $line').toList();
  }
}

class L {

  L(String className)
      : _logger = Logger(
          printer: CustomPrinter(className, PrettyPrinter()),
        ),
        _loggerNoStack = Logger(
          printer: CustomPrinter(className, PrettyPrinter(methodCount: 0)),
        );
  final Logger _logger;
  final Logger _loggerNoStack;

  // Методы для логирования с стеком
  void d(message, {error, StackTrace? stackTrace}) {
    _logger.d(message, error: error, stackTrace: stackTrace ?? StackTrace.current);
  }

  void i(message, {error, StackTrace? stackTrace}) {
    _logger.i(message, error: error, stackTrace: stackTrace ?? StackTrace.current);
  }

  void w(message, {error, StackTrace? stackTrace}) {
    _logger.w(message, error: error, stackTrace: stackTrace ?? StackTrace.current);
  }

  void e(message, {error, StackTrace? stackTrace}) {
    _logger.e(message, error: error, stackTrace: stackTrace ?? StackTrace.current);
  }

  void t(message, {error, StackTrace? stackTrace}) {
    _logger.t(message, error: error, stackTrace: stackTrace ?? StackTrace.current);
  }

  // Методы для логирования без стека
  void dNoStack(message, {error}) {
    _loggerNoStack.d(message, error: error);
  }

  void iNoStack(message, {error}) {
    _loggerNoStack.i(message, error: error);
  }

  void wNoStack(message, {error}) {
    _loggerNoStack.w(message, error: error);
  }

  void eNoStack(message, {error}) {
    _loggerNoStack.e(message, error: error);
  }

  void tNoStack(message, {error}) {
    _loggerNoStack.t(message, error: error);
  }
}
