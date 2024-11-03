// Package imports:

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threadfon/app/language/language_bloc.dart';
import 'package:threadfon/app/theme/theme_bloc.dart';
import 'package:threadfon/core/constant/enum_screen_status.dart';
import 'package:threadfon/core/constant/enum_thread_type.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';
import 'package:threadfon/features/diameter_selection/views/metric_diameter_screen.dart';
import 'package:threadfon/features/thread_type_selection/controllers/thread_type_controller.dart';
import 'package:threadfon/features/thread_type_selection/repositories/thread_type_repository.dart';
import 'package:threadfon/features/thread_type_selection/widgets/thread_type_choice_card.dart';
import 'package:threadfon/localization/generated/l10n.dart';
import 'package:threadfon/localization/l10n.dart';
import 'package:threadfon/localization/localization.dart';

class ThreadTypeSelectionScreen extends StatefulWidget {
  const ThreadTypeSelectionScreen({super.key});

  @override
  State<ThreadTypeSelectionScreen> createState() => _ThreadTypeSelectionScreenState();
}

class _ThreadTypeSelectionScreenState extends State<ThreadTypeSelectionScreen> {
  late final ThreadTypeController _controller;
  bool _isControllerInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isControllerInitialized) {
      final localStorage = context.read<LocalStorage>();
      final repository = ThreadTypeRepository();
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
    final l = context.l10n;
    print(l.app_name);
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
            title: Text(l.thread_type),
          ),
          floatingActionButton: FloatingActionButton(onPressed: () {
            context.read<LanguageBloc>().toggle();
            context.read<ThemeBloc>().toggle();
          }),
          body: Column(
            children: _controller.state.threadTypes.map((threadType) {
              return Expanded(
                child: ThreadTypeChoiceCard(
                  onTap: () => _controller.updateUserSelection(threadType),
                  svgAssetPath: threadType.svgAssetPath,
                  label: threadType.enumThreadType == EnumThreadType.f ? l.internal_thread : l.external_thread,
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
