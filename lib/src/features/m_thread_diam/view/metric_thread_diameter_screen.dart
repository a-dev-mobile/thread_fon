import 'package:flutter/material.dart';
import 'package:threadfon/src/common/data/local_storage_provider.dart';
import 'package:threadfon/src/common/log/l_setup.dart';
import 'package:threadfon/src/features/m_thread_diam/controller/diameter_controller.dart';
import 'package:threadfon/src/features/m_thread_diam/data/diameter_repository_impl.dart';
import 'package:threadfon/src/features/m_thread_diam/database_provider.dart';
import 'package:threadfon/src/features/m_thread_diam/enum_page_status.dart';
import 'package:threadfon/src/features/m_thread_male_female/view/m_thread_male_female_page.dart';

final _l = L('metric_thread_diameter_screen');

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
      final repository = DiameterRepositoryImpl(databaseService: databaseService);
      _controller = DiameterController(repository: repository, localStorage: localStorage);
      _controller
        ..addListener(_updateState)
        ..loadDiameters();
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
      if (_controller.state.status == EnumStatus.navigateToNextScreen) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) => const MThreadMaleFemalePage(),
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
    _l.d('-- build start', includeStackTrace: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Выберите Диаметр резьбы'),
      ),
      body: Builder(
        builder: (context) {
          switch (_controller.state.status) {
            case EnumStatus.init:
            case EnumStatus.load:
            case EnumStatus.navigateToNextScreen:
              return const Center(child: CircularProgressIndicator());
            case EnumStatus.error:
              return Center(child: Text('Ошибка: ${_controller.state.error}'));
            case EnumStatus.transition:
              return const Center(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ));
            case EnumStatus.success:
              return ListView.builder(
                itemCount: _controller.state.diameters.length,
                itemBuilder: (context, index) {
                  final data = _controller.state.diameters[index];
                  return ListTile(
                    title: Text(data.diam.toString()),
                    onTap: () {
                      _controller.updateUserSelection(id: data.id, diam: data.diam);
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
