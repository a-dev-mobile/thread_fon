import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threadfon/core/constant/enum_screen_status.dart';
import 'package:threadfon/core/services/api_service/api_service.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/features/diameter_selection/controllers/diameter_controller.dart';
import 'package:threadfon/features/diameter_selection/repositories/diameter_repository.dart';
import 'package:threadfon/features/pitch_selection/views/metric_pitch_screen.dart';

final _logger = LogService('metric_thread_diameter_screen');

// Создаем глобальный PageStorageBucket
final PageStorageBucket _pageBucket = PageStorageBucket();

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
  void initState() {
    super.initState();
    // Инициализация не требуется для PageStorageKey
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isControllerInitialized) {
      final apiService = context.read<ApiService>();
      final localStorage = context.read<LocalStorage>();
      final repository = DiameterRepository(apiService: apiService);
      _controller = DiameterController(repository: repository, localStorage: localStorage);
      _controller.addListener(_updateState);
      _controller.loadData();
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
      setState(() {
        if (_controller.state.status == EnumScreenStatus.success) {
          // Позиция прокрутки будет автоматически восстановлена благодаря PageStorageKey
        } else if (_controller.state.status == EnumScreenStatus.navigating) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) => const MetricPitchScreen(),
              ),
            );
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _logger.d('Building MetricDiameterScreen', includeStackTrace: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Выберите Диаметр резьбы'),
      ),
      body: PageStorage(
        bucket: _pageBucket,
        child: Builder(
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
                  key: const PageStorageKey<String>('MetricDiameterScroll'),
                  itemCount: _controller.state.diameters.length,
                  itemBuilder: (context, index) {
                    final data = _controller.state.diameters[index];
                    return ListTile(
                      title: Text(data.info),
                      onTap: () {
                        _controller.updateUserSelection(id: data.id, diameter: data.diameter);
                      },
                    );
                  },
                );
              // TODO: Handle this case.
            }
          },
        ),
      ),
    );
  }
}
