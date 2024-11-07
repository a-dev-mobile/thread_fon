import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threadfon/app/language/language_bloc.dart';
import 'package:threadfon/core/constant/enum_status.dart';
import 'package:threadfon/core/services/api_service/api_service.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/core/widgets/my_error_widget.dart';
import 'package:threadfon/core/widgets/my_load_widget.dart';
import 'package:threadfon/features/diameter_selection/bloc/diameter_bloc.dart';
import 'package:threadfon/features/diameter_selection/repositories/diameter_repository.dart';
import 'package:threadfon/features/diameter_selection/views/widget/diameter_choice_card.dart';
import 'package:threadfon/features/pitch_selection/views/pitch_selection_screen.dart';
import 'package:threadfon/localization/l10n.dart';

final _logger = LogService('metric_diameter_screen');

final class MetricDiameterScreen extends StatelessWidget {
  const MetricDiameterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Создаем экземпляр DiameterRepository здесь
    final apiService = context.read<ApiService>();
    final diameterRepository = DiameterRepository(apiService: apiService);
    final localStorage = context.read<LocalStorage>();
    final languageBloc = context.read<LanguageBloc>();

    return BlocProvider(
      create: (_) => DiameterBloc(
        repository: diameterRepository,
        localStorage: localStorage,
        languageBloc: languageBloc,
      )..loadDiameters(),
      child: const _MetricDiameterView(),
    );
  }
}

class _MetricDiameterView extends StatefulWidget {
  const _MetricDiameterView();

  @override
  State<_MetricDiameterView> createState() => _MetricDiameterViewState();
}

class _MetricDiameterViewState extends State<_MetricDiameterView> {
  late ScrollController _scrollController;
  Timer? _throttleTimer; // Таймер для троттлинга

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // Добавляем слушатель для сохранения положения скролла при изменении
    _scrollController.addListener(_onScroll);
  }

  // Метод-обработчик скролла с троттлингом
  void _onScroll() {
    if (_throttleTimer?.isActive ?? false) return;

    _throttleTimer = Timer(const Duration(seconds: 1), () {
      _saveScrollPosition();
    });
  }

  Future<void> _loadScrollPosition() async {
    final localStorage = context.read<LocalStorage>();
    final savedPosition = await localStorage.getScrollPosition();

    if (savedPosition != null && savedPosition > 0) {
      // Сохраняем позицию для последующего использования
      // Мы будем вызывать jumpTo позже, когда список будет построен
      _savedScrollPosition = savedPosition;
    }

    setState(() {});
  }

  void _saveScrollPosition() {
    final localStorage = context.read<LocalStorage>();
    localStorage.setScrollPosition(_scrollController.offset);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _throttleTimer?.cancel(); // Отменяем таймер при уничтожении виджета
    _scrollController.dispose();
    super.dispose();
  }

  double? _savedScrollPosition;

  @override
  Widget build(BuildContext context) {
    final localization = context.l10n;

    return BlocListener<DiameterBloc, DiameterState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) async {
        await _loadScrollPosition();

        if (state.status == EnumStatus.success) {
          if (_savedScrollPosition != null) {
            // Используем addPostFrameCallback, чтобы убедиться, что ListView построен
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (_scrollController.hasClients) {
                _scrollController.jumpTo(_savedScrollPosition!);
              }
            });
          }
        }

        if (state.status == EnumStatus.navigating) {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (_) => const PitchSelectionScreen(),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(localization.select_diameter),
        ),
        body: BlocBuilder<DiameterBloc, DiameterState>(
          builder: (context, state) {
            switch (state.status) {
              case EnumStatus.loading:
              case EnumStatus.navigating:
                return const MyLoadWidget();

              case EnumStatus.error:
                return MyErrorWidget(
                  errorMsg: state.errorMsg,
                  onRetry: () => context.read<DiameterBloc>().loadDiameters(),
                );
              case EnumStatus.success:
                return ListView.separated(
                  controller: _scrollController,
                  itemCount: state.diameters.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 8.0),
                  itemBuilder: (context, index) {
                    final diameter = state.diameters[index];
                    return DiameterChoiceCard(
                      info: diameter.info,
                      onTap: () => context.read<DiameterBloc>().selectDiameter(diameter),
                    );
                  },
                );
            }
          },
        ),
      ),
    );
  }
}
