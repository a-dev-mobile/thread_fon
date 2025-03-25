import 'package:dio/dio.dart';

class FallbackInterceptor extends Interceptor {
  final Dio dio;
  final String primaryUrl;
  final String fallbackUrl;
  bool usingFallback = false;

  FallbackInterceptor({
    required this.dio,
    required this.primaryUrl,
    required this.fallbackUrl,
  });

  @override
  void onError(DioException error, ErrorInterceptorHandler handler) async {
    if (!usingFallback) {
      // Switch to fallback URL on any error with the primary URL
      usingFallback = true;
      dio.options.baseUrl = fallbackUrl;

      // Retry the request with the fallback URL
      try {
        final RequestOptions request = error.requestOptions;
        final Response response = await dio.request(
          request.path,
          data: request.data,
          queryParameters: request.queryParameters,
          options: Options(
            method: request.method,
            headers: request.headers,
          ),
        );
        return handler.resolve(response);
      } catch (e) {
        // If fallback also fails, continue with the original error
        return handler.next(error);
      }
    } else {
      // Already using fallback, so just continue with the error
      return handler.next(error);
    }
  }

  // Method to reset to primary URL if needed
  void resetToPrimaryUrl() {
    if (usingFallback) {
      usingFallback = false;
      dio.options.baseUrl = primaryUrl;
    }
  }
}
