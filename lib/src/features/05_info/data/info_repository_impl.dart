import 'dart:async';

import 'package:threadfon/src/common/constant/enums_thread_type.dart';
import 'package:threadfon/src/common/data/user_selection.dart';
import 'package:threadfon/src/common/log/l_setup.dart';
import 'package:threadfon/src/common/services/api_service.dart';

import 'package:threadfon/src/features/05_info/model/info_model.dart';

final _logger = L('info_repository_impl');

class InfoRepositoryImpl {
  InfoRepositoryImpl({
    required ApiService apiService,
  }) : _apiService = apiService;

  final ApiService _apiService;

  Future<List<InfoModel>> fetchInfo({required String tolerance, required String threadType, required int id}) async {
    try {
      final response = await _apiService.get(
        'https://thread.wayofdt.de/v1/metric/info',
        queryParameters: {
          'tolerance': tolerance,
          'id': id,
          'type': threadType,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> rawData = response.data as List<dynamic>;
        final List<InfoModel> listModel =
            rawData.map((json) => InfoModel.fromJson(json as Map<String, dynamic>)).toList();
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
