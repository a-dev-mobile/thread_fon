import 'dart:async';

import 'package:dio/src/response.dart';
import 'package:threadfon/core/services/api_service/api_service.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/features/03_metric_threads/pitch_selection/models/pitch_model.dart';

final LogService _logger = LogService('pitch_repository');

class PitchRepository {
  final ApiService _apiService;

  PitchRepository({required ApiService apiService}) : _apiService = apiService;

  Future<List<PitchModel>> fetchPitch({
    required double diameter,
    required String language,
  }) async {
    try {
      final Response response = await _apiService.get(
        '/v1/metric/pitch',
        queryParameters: <String, dynamic>{
          'diameter': diameter,
          'language': language,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> rawData = response.data as List<dynamic>;
        return rawData
            .map((json) => PitchModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        _logger.e(
          'Failed to fetch pitch',
          error: 'Status code: ${response.statusCode}',
        );
        throw Exception('Failed to fetch pitch');
      }
    } catch (e, s) {
      _logger.e('Error fetching pitch', error: e, stackTrace: s);
      Error.throwWithStackTrace(e, s);
    }
  }
}
