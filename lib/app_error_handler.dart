import 'package:threadfon/src/common/log/l_setup.dart';

final _l = L('app_error_handler');

class AppErrorHandler {
  static Future<void> recordError(
    e,
    StackTrace s, {
    bool fatal = true,
  }) async {
    _l.e('🚑🚑', error: 'write to firebase');
  }
}
