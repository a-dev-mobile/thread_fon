import 'dart:async';

import 'package:threadfon/core/services/api_service/api_service.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/features/tolerance_selection/models/tolerance_model.dart';

final _logger = LogService('tolerance_repository');

class ToleranceRepository {
  ToleranceRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  final ApiService _apiService;

  Future<List<ToleranceModel>> fetchTolerances(
    int id,
    String threadType,
  ) async {
    try {
      final response = await _apiService.get(
        'https://thread.wayofdt.de/v1/metric/tolerance',
        queryParameters: {
          'type': threadType,
          'id': id,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> rawData = response.data as List<dynamic>;
        final List<ToleranceModel> listModel =
            rawData.map((json) => ToleranceModel.fromJson(json as Map<String, dynamic>)).toList();
        return listModel;
      } else {
        _logger.e(
          'Failed to fetch diameters',
          error: 'Status code: ${response.statusCode}',
        );
        throw Exception('Failed to fetch diameters');
      }
    } catch (error, stackTrace) {
      _logger.e(
        'Error fetching diameters',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}
