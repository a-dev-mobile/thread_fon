import 'dart:async';

import 'package:threadfon/core/services/api_service/api_service.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/features/imperial_threads/tolerance_selection/models/imperial_tolerance_model.dart';

final _logger = LogService('imperial_tolerance_repository');

class Imperial {
  final ApiService _apiService;

  Imperial({required ApiService apiService}) : _apiService = apiService;

  Future<ImperialToleranceModel> fetchTolerances({
    required String tpi,
    required String diameter,
  }) async {
    try {
      final response = await _apiService.get(
        '/v1/imperial/tolerance',
        queryParameters: {
          'tpi': tpi,
          'diameter': diameter,
        },
      );

      if (response.statusCode == 200) {
        return ImperialToleranceModel.fromJson(
            response.data as Map<String, dynamic>);
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
