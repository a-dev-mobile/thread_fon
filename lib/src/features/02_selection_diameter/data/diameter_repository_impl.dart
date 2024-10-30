import 'dart:async';

import 'package:threadfon/src/common/log/l_setup.dart';
import 'package:threadfon/src/common/services/api_service.dart';
import 'package:threadfon/src/features/02_selection_diameter/model/diameter_model.dart';

final _logger = L('diameter_repository_impl');

class DiameterRepositoryImpl {
  DiameterRepositoryImpl({
    required ApiService apiService,
  }) : _apiService = apiService;

  final ApiService _apiService;

  Future<List<DiameterModel>> fetchDiameters([String order = 'asc']) async {
    try {
      final response = await _apiService.get(
        'https://thread.wayofdt.de/v1/metric/diameters',
        queryParameters: {'order': order},
      );

      if (response.statusCode == 200) {
        final List<dynamic> rawData = response.data as List<dynamic>;
        final List<DiameterModel> listModel =
            rawData.map((json) => DiameterModel.fromJson(json as Map<String, dynamic>)).toList();
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
