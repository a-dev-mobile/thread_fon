import 'dart:async';

import 'package:dio/src/response.dart';
import 'package:threadfon/core/services/api_service/api_service.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/features/03_metric_threads/tolerance_selection/models/tolerance_model.dart';

final LogService _logger = LogService('tolerance_repository');

class ToleranceRepository {
  final ApiService _apiService;

  ToleranceRepository({required ApiService apiService})
    : _apiService = apiService;

  Future<List<ToleranceModel>> fetchTolerances({
    required int id,
    required String threadType,
  }) async {
    try {
      final Response response = await _apiService.get(
        '/v1/metric/tolerance',
        queryParameters: <String, dynamic>{'type': threadType, 'id': id},
      );

      if (response.statusCode == 200) {
        final List<dynamic> rawData = response.data as List<dynamic>;
        return rawData
            .map(
              (json) => ToleranceModel.fromJson(json as Map<String, dynamic>),
            )
            .toList();
      } else {
        _logger.e(
          'Failed to fetch tolerances',
          error: 'Status code: ${response.statusCode}',
        );
        throw Exception('Failed to fetch tolerances');
      }
    } catch (e, s) {
      _logger.e('Error fetching tolerances', error: e, stackTrace: s);
      Error.throwWithStackTrace(e, s);
    }
  }
}
