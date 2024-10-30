// lib/src/common/services/api_service.dart

import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  ApiService({Dio? dio})
      : _dio = dio ??
            Dio(BaseOptions(
              connectTimeout: Duration(seconds: 5),
              receiveTimeout: Duration(seconds: 3),
              headers: {
                'Content-Type': 'application/json',
              },
            )) {
    // Добавление интерсепторов, если необходимо
    _dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) {
    return _dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {dynamic data}) {
    return _dio.post(path, data: data);
  }


}
