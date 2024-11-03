import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threadfon/app/language/language_bloc.dart';
import 'package:threadfon/core/constant/enum_status.dart';
import 'package:threadfon/core/services/api_service/api_service.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/core/widgets/my_error_widget.dart';
import 'package:threadfon/features/diameter_selection/bloc/diameter_bloc.dart';
import 'package:threadfon/features/diameter_selection/repositories/diameter_repository.dart';
import 'package:threadfon/features/diameter_selection/widget/diameter_choice_card.dart';
import 'package:threadfon/features/pitch_selection/views/metric_pitch_screen.dart';
import 'package:threadfon/localization/l10n.dart';

final _logger = LogService('metric_diameter_screen');

// Создаем глобальный PageStorageBucket
final PageStorageBucket _pageBucket = PageStorageBucket();

class MetricDiameterScreen extends StatelessWidget {
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

class _MetricDiameterView extends StatelessWidget {
  const _MetricDiameterView({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = context.l10n;

    return BlocListener<DiameterBloc, DiameterState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == EnumStatus.navigating) {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (_) => const MetricPitchScreen(),
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
              case EnumStatus.initial:
              case EnumStatus.loading:
              case EnumStatus.preparingNavigation:
              case EnumStatus.navigating:
                return const Center(child: CircularProgressIndicator());

              case EnumStatus.error:
                return MyErrorWidget(
                  errorMsg: state.errorMsg,
                  onRetry: () => context.read<DiameterBloc>().loadDiameters(),
                );
              case EnumStatus.success:
                return ListView.builder(
                  itemCount: state.diameters.length,
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
