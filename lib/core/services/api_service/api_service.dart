// lib/src/common/services/api_service.dart
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:threadfon/config/env_config.dart';
import 'package:threadfon/core/services/api_service/fallback_interceptor.dart';

import 'user_agent_provider.dart';

class ApiService {
  late final Dio dio;
  final String primaryUrl = EnvConfig.apiPrimaryUrl;
  final String fallbackUrl = EnvConfig.apiFallbackUrl;
  late final FallbackInterceptor fallbackInterceptor;

  Future<ApiService> init() async {
    final String userAgent = await getUserAgent();
    dio = Dio();
    dio.options = BaseOptions(
      baseUrl: primaryUrl,
      connectTimeout: const Duration(seconds: 25),
      receiveTimeout: const Duration(seconds: 23),
      headers: <String, dynamic>{
        'Content-Type': 'application/json',
        'User-Agent': userAgent,
      },
    );

    // Disable SSL certificate validation
    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final HttpClient client = HttpClient();
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
        return client;
      },
    );

    // Add fallback interceptor
    fallbackInterceptor = FallbackInterceptor(
      dio: dio,
      primaryUrl: primaryUrl,
      fallbackUrl: fallbackUrl,
    );
    dio.interceptors.add(fallbackInterceptor);

    return this;
  }


  Future<Response<dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await dio.get(path,
          queryParameters: queryParameters, options: options);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(String path, {dynamic data, Options? options}) async {
    try {
      return await dio.post(path, data: data, options: options);
    } catch (e) {
      rethrow;
    }
  }

  // Method to reset to primary URL if needed
  void resetToPrimaryUrl() {
    fallbackInterceptor.resetToPrimaryUrl();
  }
}
