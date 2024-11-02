import 'package:flutter/material.dart';
import 'package:threadfon/core/constant/enum_screen_status.dart';
import 'package:threadfon/core/services/local_storage/local_storage_provider.dart';
import 'package:threadfon/features/tolerance_selection/repositories/tolerance_repository.dart';
import 'package:threadfon/localization/localization.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/core/services/api_service/api_provider.dart';
import 'package:threadfon/features/tolerance_selection/controllers/tolerance_controller.dart';

import 'package:threadfon/features/info/views/metric_info_screen.dart';

final _l = L('metric_tolerance_screen');

class MetricToleranceScreen extends StatefulWidget {
  const MetricToleranceScreen({super.key});

  @override
  State<MetricToleranceScreen> createState() => _MetricToleranceScreenState();
}

class _MetricToleranceScreenState extends State<MetricToleranceScreen> {
  late final ToleranceController _controller;
  bool _isControllerInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isControllerInitialized) {
      final apiService = ApiProvider.of(context);
      final localStorage = LocalStorageProvider.of(context);
      final repository =
          ToleranceRepository(apiService: apiService);
      _controller = ToleranceController(
          repository: repository, localStorage: localStorage);
      _controller
        ..addListener(_updateState)
        ..loadTolerances();
      _isControllerInitialized = true;
    }
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_updateState)
      ..dispose();
    super.dispose();
  }

  void _updateState() {
    if (mounted) {
      if (_controller.state.status == EnumScreenStatus.navigating) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) => const MetricInfoScreen(),
            ),
          );
        });
        return;
      }

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    _l.d('Building MetricToleranceScreen', includeStackTrace: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(Localization.of(context).thread_tolerance),
      ),
      body: Builder(
        builder: (context) {
          switch (_controller.state.status) {
            case EnumScreenStatus.initial:
            case EnumScreenStatus.loading:
            case EnumScreenStatus.navigating:
              return const Center(child: CircularProgressIndicator());
            case EnumScreenStatus.error:
              return Center(child: Text('Error: ${_controller.state.error}'));

            case EnumScreenStatus.loadingNavigating:
              return const Scaffold(
                body: Center(child: LinearProgressIndicator()),
              );
            case EnumScreenStatus.success:
              return ListView.builder(
                itemCount: _controller.state.model.length,
                itemBuilder: (context, index) {
                  final data = _controller.state.model[index];
                  return ListTile(
                    title: Text(data.info),
                    onTap: () {
                      _controller.updateUserSelection(
                         
                          tolerance: data.tolerance,
                          description: data.info);
                    },
                  );
                },
              );
          }
        },
      ),
    );
  }
}
