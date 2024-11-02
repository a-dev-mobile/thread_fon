// lib/src/common/services/correlation_id_interceptor.dart

import 'package:dio/dio.dart';

class CorrelationIdInterceptor extends Interceptor {
  String? _correlationId;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Добавляем X-Correlation-Id, если он был сохранен
    if (_correlationId != null) {
      options.headers['X-Correlation-Id'] = _correlationId;
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Сохраняем X-Correlation-Id из заголовков ответа
    if (response.headers['X-Correlation-Id'] != null) {
      _correlationId = response.headers['X-Correlation-Id']!.first;
    }
    handler.next(response);
  }
}
