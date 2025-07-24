import 'dart:async';

import 'package:dio/src/response.dart';
import 'package:threadfon/core/services/api_service/api_service.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/features/03_metric_threads/diameter_selection/models/metric_diameter_model.dart';

final LogService _logger = LogService('diameter_repository');

class DiameterRepository {
  final ApiService _apiService;

  DiameterRepository({required ApiService apiService})
    : _apiService = apiService;

  Future<List<MetricDiameterModel>> fetchDiameters({
    String order = 'asc',
  }) async {
    try {
      final Response response = await _apiService.get(
        '/v1/metric/diameters',
        queryParameters: <String, dynamic>{'order': order},
      );

      if (response.statusCode == 200) {
        final List<dynamic> rawData = response.data;
        return rawData
            .map(
              (json) =>
                  MetricDiameterModel.fromJson(json as Map<String, dynamic>),
            )
            .toList();
      } else {
        _logger.e(
          'Failed to fetch diameters. Status code: ${response.statusCode}',
        );
        throw Exception('Failed to fetch diameters');
      }
    } catch (e, s) {
      _logger.e('Error fetching diameters', error: e, stackTrace: s);
      Error.throwWithStackTrace(e, s);
    }
  }
}
