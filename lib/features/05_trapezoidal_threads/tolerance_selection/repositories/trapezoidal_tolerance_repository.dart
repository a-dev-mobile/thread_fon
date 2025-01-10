import 'dart:async';

import 'package:dio/src/response.dart';
import 'package:threadfon/core/services/api_service/api_service.dart';
import 'package:threadfon/core/services/logging/logger.dart';

import 'package:threadfon/features/05_trapezoidal_threads/tolerance_selection/models/trapezoidal_tolerance_model.dart';

final LogService _logger = LogService('trapezoidal_tolerance_repository');

class TrapezoidalToleranceRepository {
  final ApiService _apiService;

  TrapezoidalToleranceRepository({required ApiService apiService})
      : _apiService = apiService;

  Future<TrapezoidalToleranceModel> fetchTolerances({
    required String pitch,
    required String diameter,
  }) async {
    try {
      final Response response = await _apiService.get(
        '/v1/trapezoidal/tolerance',
        queryParameters: <String, dynamic>{
          'pitch': pitch,
          'diameter': diameter,
        },
      );

      if (response.statusCode == 200) {
        return TrapezoidalToleranceModel.fromJson(
            response.data as Map<String, dynamic>);
      } else {
        _logger.e(
          'Failed to fetch tolerances',
          error: 'Status code: ${response.statusCode}',
        );
        throw Exception('Failed to fetch tolerances');
      }
    } catch (e, s) {
      _logger.e(
        'Error fetching tolerances',
        error: e,
        stackTrace: s,
      );
      Error.throwWithStackTrace(e, s);
    }
  }
}
