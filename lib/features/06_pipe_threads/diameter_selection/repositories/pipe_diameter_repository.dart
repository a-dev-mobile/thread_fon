import 'dart:async';

import 'package:dio/src/response.dart';
import 'package:threadfon/core/services/api_service/api_service.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/features/06_pipe_threads/diameter_selection/models/pipe_diameter_model.dart';

final LogService _logger = LogService('pipe_diameter_repository');

class PipeDiameterRepository {
  final ApiService _apiService;

  PipeDiameterRepository({required ApiService apiService})
    : _apiService = apiService;

  Future<PipeDiameterModel> fetchDiameters() async {
    try {
      final Response response = await _apiService.get('/v1/pipe/diameters');

      if (response.statusCode == 200) {
        return PipeDiameterModel.fromJson(
          response.data as Map<String, dynamic>,
        );
      } else {
        _logger.e(
          'Failed to fetch diameters',
          error: 'Status code: ${response.statusCode}',
        );
        throw Exception('Failed to fetch diameters');
      }
    } catch (e, s) {
      _logger.e('Error fetching diameters', error: e, stackTrace: s);
      Error.throwWithStackTrace(e, s);
    }
  }
}
