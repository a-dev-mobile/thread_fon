import 'dart:async';

import 'package:dio/dio.dart';
import 'package:threadfon/core/services/api_service/api_service.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/features/06_pipe_threads/info/models/pipe_info_model.dart';

final LogService _logger = LogService('pipe_info_repository');
const String _baseUrl = '/v1/pipe';

class PipeInfoRepository {
  PipeInfoRepository({required ApiService apiService})
    : _apiService = apiService;

  final ApiService _apiService;

  Future<PipeInfoModel> fetchPipeInfo({
    required int id,
    required String language,
    required String units,
    required int precision,
  }) async {
    const String endpoint = '$_baseUrl/info';
    try {
      final Response response = await _apiService.get(
        endpoint,
        queryParameters: <String, dynamic>{
          'id': id.toString(),
          'language': language,
          'units': units,
          'precision': precision,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> rawData =
            response.data as Map<String, dynamic>;
        return PipeInfoModel.fromJson(rawData);
      } else {
        final String errorMessage =
            'Failed to fetch info. Status code: ${response.statusCode}';
        _logger.e(errorMessage);
        throw Exception(errorMessage);
      }
    } catch (e, s) {
      _logger.e('Error fetching info', error: e, stackTrace: s);
      Error.throwWithStackTrace(e, s);
    }
  }

  Future<String> fetchSvgDimensions({
    required String diameter,
    required String pitch,
    required String type,
    required String tolerance,
    required String language,
    required String units,
    required int precision,
    required String theme,
  }) async {
    const String endpoint = '$_baseUrl/svg-dimensions';
    try {
      final Response response = await _apiService.get(
        endpoint,
        queryParameters: <String, dynamic>{
          'diameter': diameter,
          'pitch': pitch,
          'type': type,
          'tolerance': tolerance,
          'language': language,
          'units': units,
          'precision': precision,
          'theme': theme,
        },
        options: Options(responseType: ResponseType.plain),
      );

      if (response.statusCode == 200) {
        return response.data as String;
      } else {
        final String errorMessage =
            'Failed to fetch SVG dimensions. Status code: ${response.statusCode}';
        _logger.e(errorMessage);
        throw Exception(errorMessage);
      }
    } catch (e, s) {
      _logger.e('Error fetching SVG dimensions', error: e, stackTrace: s);
      Error.throwWithStackTrace(e, s);
    }
  }

  Future<String> fetchSvgAnnotations({
    required String type,
    required String language,
    required String theme,
  }) async {
    const String endpoint = '$_baseUrl/svg-annotations';
    try {
      final Response response = await _apiService.get(
        endpoint,
        queryParameters: <String, dynamic>{
          'type': type,
          'language': language,
          'theme': theme,
        },
        options: Options(responseType: ResponseType.plain),
      );

      if (response.statusCode == 200) {
        return response.data as String;
      } else {
        final String errorMessage =
            'Failed to fetch SVG annotations. Status code: ${response.statusCode}';
        _logger.e(errorMessage);
        throw Exception(errorMessage);
      }
    } catch (e, s) {
      _logger.e('Error fetching SVG annotations', error: e, stackTrace: s);
      Error.throwWithStackTrace(e, s);
    }
  }
}
