// lib/src/common/services/api_service.dart
import 'package:dio/dio.dart';

import 'user_agent_provider.dart';

class ApiService {
  late final Dio dio;

  Future<ApiService> init() async {
    final String userAgent = await getUserAgent();
    dio = Dio();
    dio.options = BaseOptions(
      // baseUrl: 'http://10.0.3.2:5000',
      // baseUrl: 'https://dev-thread-api.wayofdt.de',
      baseUrl: 'https://thread-api.wayofdt.de',
      connectTimeout: const Duration(seconds: 25),
      receiveTimeout: const Duration(seconds: 23),
      headers: <String, dynamic>{
        'Content-Type': 'application/json',
        'User-Agent': userAgent,
      },
    );

    // dio.interceptors.add(CorrelationIdInterceptor());

    return this;
  }

  Future<Response<dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return dio.get(path, queryParameters: queryParameters, options: options);
  }

  Future<Response> post(String path, {dynamic data, Options? options}) async {
    return dio.post(path, data: data, options: options);
  }
}
