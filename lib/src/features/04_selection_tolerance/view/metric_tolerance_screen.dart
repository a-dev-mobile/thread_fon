import 'package:flutter/material.dart';
import 'package:threadfon/src/common/constant/enum_screen_status.dart';
import 'package:threadfon/src/common/data/local_storage_provider.dart';
import 'package:threadfon/src/common/localization/localization.dart';
import 'package:threadfon/src/common/log/l_setup.dart';
import 'package:threadfon/src/common/services/api_provider.dart';
import 'package:threadfon/src/features/04_selection_tolerance/controller/tolerance_controller.dart';
import 'package:threadfon/src/features/04_selection_tolerance/data/tolerance_repository_impl.dart';
import 'package:threadfon/src/features/05_info/view/metric_info_screen.dart';

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
          ToleranceRepositoryImpl(apiService: apiService);
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
