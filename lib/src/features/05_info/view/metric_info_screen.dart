import 'package:flutter/material.dart';
import 'package:threadfon/src/common/constant/enum_screen_status.dart';
import 'package:threadfon/src/common/data/local_storage_provider.dart';
import 'package:threadfon/src/common/localization/localization.dart';
import 'package:threadfon/src/common/log/l_setup.dart';
import 'package:threadfon/src/features/02_selection_diameter/database_provider.dart';
import 'package:threadfon/src/features/02_selection_diameter/view/metric_diameter_screen.dart';
import 'package:threadfon/src/features/05_info/controller/info_controller.dart';
import 'package:threadfon/src/features/05_info/data/info_repository_impl.dart';

final _l = L('metric_info_screen');

class MetricInfoScreen extends StatefulWidget {
  const MetricInfoScreen({super.key});

  @override
  State<MetricInfoScreen> createState() => _MetricInfoScreenState();
}

class _MetricInfoScreenState extends State<MetricInfoScreen> {
  late final InfoController _controller;
  bool _isControllerInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isControllerInitialized) {
      final databaseService = DatabaseProvider.of(context);
      final localStorage = LocalStorageProvider.of(context);
      final repository = InfoRepositoryImpl(databaseService: databaseService);
      _controller =
          InfoController(repository: repository, localStorage: localStorage);
      _controller
        ..addListener(_updateState)
        ..load();
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
              builder: (context) => const MetricDiameterScreen(),
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
    _l.d('Building MetricInfoScreen', includeStackTrace: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(Localization.of(context).threads_info),
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
                    title: Text(data.description),
                    onTap: () {
                      _controller.updateUserSelection(
                          id: data.id, info: data.info);
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
