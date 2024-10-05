// Package imports:

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:threadfon/src/common/constant/enum_screen_status.dart';
import 'package:threadfon/src/common/data/local_storage_provider.dart';
import 'package:threadfon/src/common/localization/localization.dart';
import 'package:threadfon/src/features/diameter_selection/view/metric_diameter_screen.dart';
import 'package:threadfon/src/features/thread_type_selection/controller/thread_type_controller.dart';
import 'package:threadfon/src/features/thread_type_selection/data/thread_type_repository_impl.dart';

class ThreadTypeSelectionPage extends StatefulWidget {
  const ThreadTypeSelectionPage({super.key});

  @override
  _ThreadTypeSelectionPageState createState() =>
      _ThreadTypeSelectionPageState();
}

class _ThreadTypeSelectionPageState extends State<ThreadTypeSelectionPage> {
  late final ThreadTypeController _controller;
  bool _isControllerInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isControllerInitialized) {
      final localStorage = LocalStorageProvider.of(context);
      final repository = ThreadTypeRepositoryImpl();
      _controller = ThreadTypeController(
        repository: repository,
        localStorage: localStorage,
      );
      _controller
        ..addListener(_updateState)
        ..loadThreadTypes();
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
    switch (_controller.state.status) {
      case EnumScreenStatus.initial:
      case EnumScreenStatus.loading:
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      case EnumScreenStatus.loadingNavigating:
        return const Scaffold(
          body: Center(child: LinearProgressIndicator()),
        );
      case EnumScreenStatus.error:
        return Scaffold(
          body: Center(child: Text('Error: ${_controller.state.error}')),
        );
      case EnumScreenStatus.success:
        return Scaffold(
          appBar: AppBar(
            title: Text(Localization.of(context).thread_type),
          ),
          body: Column(
            children: _controller.state.threadTypes.map((threadType) {
              return Expanded(
                child: ThreadTypeChoiceCard(
                  onTap: () => _controller.selectThreadType(threadType),
                  svgAssetPath: threadType.svgAssetPath,
                  label: 'threadType.name',
                ),
              );
            }).toList(),
          ),
        );
      case EnumScreenStatus.navigating:
        // This case is handled in _updateState()
        return const SizedBox.shrink();
      // TODO: Handle this case.
    }
  }
}

class ThreadTypeChoiceCard extends StatelessWidget {
  const ThreadTypeChoiceCard({
    required this.svgAssetPath,
    required this.label,
    required this.onTap,
    super.key,
  });

  final String svgAssetPath;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cardColor = Theme.of(context).cardColor;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 3,
      margin: const EdgeInsets.all(8),
      color: cardColor,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SvgPicture.asset(svgAssetPath),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                label.toUpperCase(),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
