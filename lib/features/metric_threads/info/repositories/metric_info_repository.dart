import 'dart:async';

import 'package:dio/dio.dart';
import 'package:threadfon/core/services/api_service/api_service.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/features/metric_threads/info/models/metric_info_model.dart';

final _logger = LogService('info_repository');
const String _baseUrl = '/v1/metric';

class MetricInfoRepository {
  MetricInfoRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  final ApiService _apiService;

  Future<MetricInfoModel> fetchInfo({
    required String tolerance,
    required String threadType,
    required String language,
    required String units,
    required double pitch,
    required int precision,
    required double diameter,
  }) async {
    final endpoint = '$_baseUrl/info';
    try {
      final response = await _apiService.get(
        endpoint,
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
        final Map<String, dynamic> rawData =
            response.data as Map<String, dynamic>;
        return MetricInfoModel.fromJson(rawData);
      } else {
        final errorMessage =
            'Failed to fetch info. Status code: ${response.statusCode}';
        _logger.e(errorMessage);
        throw Exception(errorMessage);
      }
    } catch (e, s) {
      _logger.e('Error fetching info', error: e, stackTrace: s);
      Error.throwWithStackTrace(e, s);
    }
  }

  Future<String> fetchSvgData({
    required String tolerance,
    required String threadType,
    required double pitch,
    required double diameter,
    required String theme,
    required String units,
    required String language,
    required int precision,
    bool showDimensions = true,
  }) async {
    final endpoint = '$_baseUrl/svg';
    try {
      final response = await _apiService.get(
        endpoint,
        queryParameters: {
          'tolerance': tolerance,
          'type': threadType,
          'pitch': pitch,
          'diameter': diameter,
          'theme': theme,
          'units': units,
          'precision': precision,
          'language': language,
          'show_dimensions': showDimensions.toString(),
        },
        options: Options(responseType: ResponseType.plain),
      );

      if (response.statusCode == 200) {
        return response.data as String;
      } else {
        final errorMessage =
            'Failed to fetch SVG data. Status code: ${response.statusCode}';
        _logger.e(errorMessage);
        throw Exception(errorMessage);
      }
    } catch (e, s) {
      _logger.e('Error fetching SVG data', error: e, stackTrace: s);
      Error.throwWithStackTrace(e, s);
    }
  }
}
