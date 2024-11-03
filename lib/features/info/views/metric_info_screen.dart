import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:threadfon/app/theme/theme_bloc.dart';
import 'package:threadfon/core/constant/enum_screen_status.dart';
import 'package:threadfon/core/services/api_service/api_service.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/features/diameter_selection/views/metric_diameter_screen.dart';
import 'package:threadfon/features/info/controllers/info_controller.dart';
import 'package:threadfon/features/info/repositories/info_repository.dart';
import 'package:threadfon/localization/localization.dart';

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
      final apiService = context.read<ApiService>();
      final localStorage = context.read<LocalStorage>();
      final repository = InfoRepository(apiService: apiService);
      _controller = InfoController(repository: repository, localStorage: localStorage);
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
              return Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: _controller.state.model.length,
                    itemBuilder: (context, index) {
                      final data = _controller.state.model[index];
                      return ListTile(
                        title: Text(data.toString()),
                        onTap: () {
                          _controller.updateUserSelection(data);
                        },
                      );
                    },
                  ),
                  Expanded(
                    child: _controller.state.svgData == null
                        ? const Center(child: CircularProgressIndicator())
                        : InteractiveViewer(
                            minScale: 0.5,
                            maxScale: 10.0,
                            child: Builder(builder: (context) {
                              final isDark = context.select((ThemeBloc bloc) => bloc.state.themeMode == ThemeMode.dark);
                              return SvgPicture.string(
                                _controller.state.svgData!,
                                color: isDark ? Colors.white : null,
                                placeholderBuilder: (BuildContext context) =>
                                    const Center(child: CircularProgressIndicator()),
                                fit: BoxFit.contain,
                              );
                            }),
                          ),
                  ),
                ],
              );
          }
        },
      ),
    );
  }
}
