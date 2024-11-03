import 'package:flutter/material.dart';
import 'package:threadfon/app/language/language_notifier.dart';
import 'package:threadfon/core/constant/enum_screen_status.dart';
import 'package:threadfon/core/services/api_service/api_provider.dart';
import 'package:threadfon/core/services/local_storage/local_storage_provider.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/features/pitch_selection/controllers/pitch_controller.dart';
import 'package:threadfon/features/pitch_selection/repositories/pitch_repository.dart';
import 'package:threadfon/features/tolerance_selection/views/metric_tolerance_screen.dart';
import 'package:threadfon/localization/localization.dart';

final _l = L('metric_pitch_screen');

class MetricPitchScreen extends StatefulWidget {
  const MetricPitchScreen({
    super.key,
  });

  @override
  State<MetricPitchScreen> createState() => _MetricPitchScreenState();
}

class _MetricPitchScreenState extends State<MetricPitchScreen> {
  late final PitchController _controller;
  bool _isControllerInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final lang = LanguageNotifier.watch(context);

    if (!_isControllerInitialized) {
      final apiService = ApiProvider.of(context);
      final localStorage = LocalStorageProvider.of(context);
      final repository = PitchRepository(apiService: apiService);
      _controller = PitchController(repository: repository, localStorage: localStorage, language: lang);
      _controller
        ..addListener(_updateState)
        ..loadData();
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
              builder: (context) => const MetricToleranceScreen(),
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
    _l.d('Building MetricPitchScreen', includeStackTrace: false);
    final lang = LanguageNotifier.watch(context);


    return Scaffold(
      appBar: AppBar(
        title: Text(Localization.of(context).thread_pitch),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          LanguageNotifier.read(context).toggleLocale;
        },
        child: const Icon(Icons.refresh),
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
                      _controller.updateUserSelection(id: data.id!, pitch: data.pitch!);
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
