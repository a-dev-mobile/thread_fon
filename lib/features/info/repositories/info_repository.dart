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

  Future<List<InfoModel>> fetchInfo(
      {required String tolerance,
      required String threadType,
      required double pitch,
      required double diameter}) async {
    try {
      final response = await _apiService.get(
        'https://thread.wayofdt.de/v1/metric/info',
        queryParameters: {
          'tolerance': tolerance,
          'diameter': diameter,
          'pitch': pitch,
          'type': threadType,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> rawData = response.data as List<dynamic>;
        final List<InfoModel> listModel = rawData
            .map((json) => InfoModel.fromJson(json as Map<String, dynamic>))
            .toList();
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

  Future<String> fetchSvgData({
    required String tolerance,
    required String threadType,
    required double pitch,
    required double diameter,
  }) async {
    try {
      final response = await _apiService.get(
        'https://thread.wayofdt.de/v1/metric/thread-svg',
        queryParameters: {
          'tolerance': tolerance,
          'diameter': diameter,
          'pitch': pitch,
          'type': threadType,
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
