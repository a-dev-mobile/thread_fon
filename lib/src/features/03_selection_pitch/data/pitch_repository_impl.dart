import 'dart:async';

import 'package:threadfon/src/common/log/l_setup.dart';
import 'package:threadfon/src/common/services/api_service.dart';
import 'package:threadfon/src/features/03_selection_pitch/model/pitch_model.dart';

final _logger = L('pitch_repository_impl');

class PitchRepositoryImpl {
  PitchRepositoryImpl({
    required ApiService apiService,
  }) : _apiService = apiService;

  final ApiService _apiService;

  Future<List<PitchModel>> fetchPitch(double diameter, [String language = 'ru']) async {
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
        _logger.e(
          'Failed to fetch  Pitch',
          error: 'Status code: ${response.statusCode}',
        );
        throw Exception('Failed to fetch Pitch');
      }
    } catch (error, stackTrace) {
      _logger.e(
        'Error fetching Pitch',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}
