import 'dart:async';

import 'package:dio/dio.dart';
import 'package:threadfon/core/services/api_service/api_service.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/features/info/models/info_model.dart';

final _logger = LogService('info_repository');

class InfoRepository {
  InfoRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  final ApiService _apiService;

  Future<InfoModel> fetchInfo({
    required String tolerance,
    required String threadType,
    required String language,
    required String units,
    required double pitch,
    required int precision,
    required double diameter,
  }) async {
    try {
      final response = await _apiService.get(
        'https://thread.wayofdt.de/v1/metric/info',
        queryParameters: {
          'tolerance': tolerance,
          'diameter': diameter,
          'pitch': pitch,
          'type': threadType,
          'language': language,
          'units': units,
          'precision': precision,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> rawData = response.data as Map<String, dynamic>;
        return InfoModel.fromJson(rawData);
      } else {
        _logger.e(
          'Failed to fetch info',
          error: 'Status code: ${response.statusCode}',
        );
        throw Exception('Failed to fetch info');
      }
    } catch (error, stackTrace) {
      _logger.e(
        'Error fetching info',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<String> fetchSvgData({
    required String tolerance,
    required String threadType,
    required double pitch,
    required double diameter,
    required String theme,
    required String units,
    required int precision,
      bool showDimensions = true,
  }) async {
    try {
      final response = await _apiService.get(
        'https://thread.wayofdt.de/v1/metric/thread-svg',
        queryParameters: {
          'tolerance': tolerance,
          'type': threadType,
          'pitch': pitch,
          'diameter': diameter,
          'theme': theme,
          'units': units,
          'precision': precision,
                  'showDimensions': showDimensions.toString(), 
        },
        options: Options(responseType: ResponseType.plain),
      );

      if (response.statusCode == 200) {
        final svgData = response.data as String;
        return svgData;
      } else {
        _logger.e(
          'Failed to fetch SVG data',
          error: 'Status code: ${response.statusCode}',
        );
        throw Exception('Failed to fetch SVG data');
      }
    } catch (error, stackTrace) {
      _logger.e(
        'Error fetching SVG data',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}
