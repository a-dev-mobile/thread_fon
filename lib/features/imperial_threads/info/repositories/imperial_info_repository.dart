import 'dart:async';

import 'package:dio/dio.dart';
import 'package:threadfon/core/services/api_service/api_service.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/features/imperial_threads/info/models/imperial_info_model.dart';

final _logger = LogService('imperial_info_repository');
const String _baseUrl = '/v1/imperial';

class ImperialInfoRepository {
  ImperialInfoRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  final ApiService _apiService;

  Future<ImperialInfoModel> fetchImperialInfo({
    required int id,
    required String type,
    required String language,
    required String units,
    required int precision,
  }) async {
    final endpoint = '$_baseUrl/info';
    try {
      final response = await _apiService.get(
        endpoint,
        queryParameters: {
          'id': id,
          'type': type,
          'language': language,
          'units': units,
          'precision': precision,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> rawData =
            response.data as Map<String, dynamic>;
        return ImperialInfoModel.fromJson(rawData);
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
    required int id,
    required String type,
    required String language,
    required String units,
    required int precision,
    required String theme,
    required bool showDimensions,
  }) async {
    final endpoint = '$_baseUrl/svg';
    try {
      final response = await _apiService.get(
        endpoint,
        queryParameters: {
          'id': id,
          'type': type,
          'language': language,
          'units': units,
          'precision': precision,
          'theme': theme,
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
      _logger.e('Error fetching SVG data',
          error: e, stackTrace: s);
      Error.throwWithStackTrace(e, s);
    }
  }
}
