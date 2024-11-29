// lib/src/common/services/api_service.dart

import 'package:dio/dio.dart';
import 'correlation_id_interceptor.dart';

class ApiService {
  final Dio _dio;

  ApiService({Dio? dio})
      : _dio = dio ??
            Dio(BaseOptions(
              connectTimeout: Duration(seconds: 25),
              receiveTimeout: Duration(seconds: 23),
              headers: {
                'Content-Type': 'application/json',
              },
            )) {
    // Добавление интерсепторов
    // _dio.interceptors.add(LogInterceptor(responseBody: true));
    _dio.interceptors.add(CorrelationIdInterceptor());
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.get(path, queryParameters: queryParameters, options: options);
  }

  Future<Response> post(String path, {dynamic data}) {
    return _dio.post(path, data: data);
  }
}
