import 'package:flutter/material.dart';
import 'package:threadfon/src/common/constant/enum_screen_status.dart';
import 'package:threadfon/src/common/data/local_storage_provider.dart';
import 'package:threadfon/src/common/log/l_setup.dart';
import 'package:threadfon/src/features/diameter_selection/controller/diameter_controller.dart';
import 'package:threadfon/src/features/diameter_selection/data/diameter_repository_impl.dart';
import 'package:threadfon/src/features/diameter_selection/database_provider.dart';
import 'package:threadfon/src/features/thread_type_selection/view/thread_type_selection_page.dart';

final _l = CustomLogger('metric_thread_diameter_screen');

class MetricDiameterScreen extends StatefulWidget {
  const MetricDiameterScreen({
    super.key,
  });

  @override
  State<MetricDiameterScreen> createState() => _MetricDiameterScreenState();
}

class _MetricDiameterScreenState extends State<MetricDiameterScreen> {
  late final DiameterController _controller;
  bool _isControllerInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isControllerInitialized) {
      final databaseService = DatabaseProvider.of(context);
      final localStorage = LocalStorageProvider.of(context);
      final repository =
          DiameterRepositoryImpl(databaseService: databaseService);
      _controller = DiameterController(
          repository: repository, localStorage: localStorage);
      _controller.addListener(_updateState);
      _controller.loadDiameters();
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
              builder: (context) => const ThreadTypeSelectionPage(),
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
    _l.d('Building MetricDiameterScreen', includeStackTrace: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Выберите Диаметр резьбы'),
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
                itemCount: _controller.state.diameters.length,
                itemBuilder: (context, index) {
                  final data = _controller.state.diameters[index];
                  return ListTile(
                    title: Text(data.diameter.toString()),
                    onTap: () {
                      _controller.updateUserSelection(
                          id: data.id, diameter: data.diameter);
                    },
                  );
                },
              );
            // TODO: Handle this case.
          }
        },
      ),
    );
  }
}
