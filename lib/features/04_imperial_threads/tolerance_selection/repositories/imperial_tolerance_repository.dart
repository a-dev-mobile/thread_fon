import 'dart:async';

import 'package:dio/src/response.dart';
import 'package:threadfon/core/services/api_service/api_service.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/features/04_imperial_threads/tolerance_selection/models/imperial_tolerance_model.dart';

final LogService _logger = LogService('imperial_tolerance_repository');

class Imperial {
  final ApiService _apiService;

  Imperial({required ApiService apiService}) : _apiService = apiService;

  Future<ImperialToleranceModel> fetchTolerances({
    required String tpi,
    required String diameter,
  }) async {
    try {
      final Response response = await _apiService.get(
        '/v1/imperial/tolerance',
        queryParameters: <String, dynamic>{
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
