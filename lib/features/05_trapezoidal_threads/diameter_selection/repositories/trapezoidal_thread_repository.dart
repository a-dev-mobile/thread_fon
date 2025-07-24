// lib/features/trapezoidal_threads/repositories/trapezoidal_thread_repository.dart

import 'package:dio/dio.dart';
import 'package:threadfon/core/services/api_service/api_service.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/features/05_trapezoidal_threads/diameter_selection/models/trapezoidal_thread_model.dart';

final LogService _logger = LogService('trapezoidal_thread_repository');

class TrapezoidalThreadRepository {
  final ApiService _apiService;

  TrapezoidalThreadRepository({required ApiService apiService})
    : _apiService = apiService;

  Future<List<TrapezoidalThreadModel>> fetchThreads() async {
    try {
      final Response response = await _apiService.get(
        '/v1/trapezoidal/diameters',
      );

      if (response.statusCode == 200) {
        final List<dynamic> rawData = response.data;

        return rawData
            .map(
              (dynamic json) =>
                  TrapezoidalThreadModel.fromJson(json as Map<String, dynamic>),
            )
            .toList();
      } else {
        _logger.e(
          'Failed to fetch trapezoidal threads. Status code: ${response.statusCode}',
        );
        throw Exception('Failed to fetch trapezoidal threads');
      }
    } catch (e, s) {
      _logger.e('Error fetching trapezoidal threads', error: e, stackTrace: s);
      Error.throwWithStackTrace(e, s);
    }
  }
}
