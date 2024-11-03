import 'dart:async';

import 'package:threadfon/core/services/api_service/api_service.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/features/pitch_selection/models/pitch_model.dart';

final _l = L('pitch_repository');

class PitchRepository {
  PitchRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  final ApiService _apiService;

  Future<List<PitchModel>> fetchPitch(double diameter, String language) async {
    try {
      final response = await _apiService.get(
        'https://thread.wayofdt.de/v1/metric/pitch',
        queryParameters: {
          'diameter': diameter,
          'language': language,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> rawData = response.data as List<dynamic>;
        final List<PitchModel> listModel =
            rawData.map((json) => PitchModel.fromJson(json as Map<String, dynamic>)).toList();
        return listModel;
      } else {
        _l.e(
          'Failed to fetch  Pitch',
          error: 'Status code: ${response.statusCode}',
        );
        throw Exception('Failed to fetch Pitch');
      }
    } catch (error, stackTrace) {
      _l.e(
        'Error fetching Pitch',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}
