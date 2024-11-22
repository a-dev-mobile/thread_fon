import 'dart:async';

import 'package:threadfon/core/services/api_service/api_service.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/features/diameter_selection/models/diameter_model.dart';

final _logger = LogService('diameter_repository');

class DiameterRepository {
  final ApiService _apiService;

  DiameterRepository({required ApiService apiService})
      : _apiService = apiService;

  Future<List<DiameterModel>> fetchDiameters({String order = 'asc'}) async {
    try {
      final response = await _apiService.get(
        'https://thread-api.wayofdt.de/v1/metric/diameters',
        queryParameters: {'order': order},
      );

      if (response.statusCode == 200) {
        final List<dynamic> rawData = response.data;
        return rawData
            .map((json) => DiameterModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        _logger.e(
            'Failed to fetch diameters. Status code: ${response.statusCode}');
        throw Exception('Failed to fetch diameters');
      }
    } catch (error, stackTrace) {
      _logger.e('Error fetching diameters',
          error: error, stackTrace: stackTrace);
      rethrow;
    }
  }
}
