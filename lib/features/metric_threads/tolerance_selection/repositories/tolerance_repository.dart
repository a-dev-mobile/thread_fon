import 'dart:async';

import 'package:threadfon/core/services/api_service/api_service.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/features/metric_threads/tolerance_selection/models/tolerance_model.dart';

final _logger = LogService('tolerance_repository');

class ToleranceRepository {
  final ApiService _apiService;

  ToleranceRepository({required ApiService apiService})
      : _apiService = apiService;

  Future<List<ToleranceModel>> fetchTolerances({
    required int id,
    required String threadType,
  }) async {
    try {
      final response = await _apiService.get(
        '/v1/metric/tolerance',
        queryParameters: {
          'type': threadType,
          'id': id,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> rawData = response.data as List<dynamic>;
        return rawData
            .map(
                (json) => ToleranceModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        _logger.e(
          'Failed to fetch tolerances',
          error: 'Status code: ${response.statusCode}',
        );
        throw Exception('Failed to fetch tolerances');
      }
    } catch (error, stackTrace) {
      _logger.e(
        'Error fetching tolerances',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}
