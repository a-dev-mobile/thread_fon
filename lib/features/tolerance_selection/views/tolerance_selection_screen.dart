import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threadfon/app/language/language_bloc.dart';
import 'package:threadfon/core/constant/enum_status.dart';
import 'package:threadfon/core/services/api_service/api_service.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/core/widgets/my_error_widget.dart';
import 'package:threadfon/core/widgets/my_load_widget.dart';
import 'package:threadfon/features/info/views/info_screen.dart';
import 'package:threadfon/features/tolerance_selection/bloc/tolerance_bloc.dart';
import 'package:threadfon/features/tolerance_selection/repositories/tolerance_repository.dart';
import 'package:threadfon/features/tolerance_selection/views/tolerance_choice_card.dart';
import 'package:threadfon/localization/l10n.dart';

final _logger = LogService('metric_tolerance_screen');

class ToleranceSelectionScreen extends StatelessWidget {
  const ToleranceSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final apiService = context.read<ApiService>();
    final toleranceRepository = ToleranceRepository(apiService: apiService);
    final localStorage = context.read<LocalStorage>();
    final languageBloc = context.read<LanguageBloc>();

    return BlocProvider(
      create: (_) => ToleranceBloc(
        repository: toleranceRepository,
        localStorage: localStorage,
        languageBloc: languageBloc,
      )..loadTolerances(),
      child: const _ToleranceSelectionView(),
    );
  }
}

class _ToleranceSelectionView extends StatelessWidget {
  const _ToleranceSelectionView();

  @override
  Widget build(BuildContext context) {
    final localization = context.l10n;

    return BlocListener<ToleranceBloc, ToleranceState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == EnumStatus.navigating) {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) => const InfoScreen(),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(localization.select_tolerance),
        ),
        body: BlocBuilder<ToleranceBloc, ToleranceState>(
          builder: (context, state) {
            switch (state.status) {
              case EnumStatus.initial:
              case EnumStatus.loading:
              case EnumStatus.preparingNavigation:
              case EnumStatus.navigating:
                return const MyLoadWidget();

              case EnumStatus.error:
                return MyErrorWidget(
                  errorMsg: state.errorMsg,
                  onRetry: () => context.read<ToleranceBloc>().loadTolerances(),
                );

              case EnumStatus.success:
                return ListView.separated(
                  itemCount: state.tolerances.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 8.0),
                  itemBuilder: (context, index) {
                    final tolerance = state.tolerances[index];
                    return ToleranceChoiceCard(
                      tolerance: tolerance,
                      onTap: () => context.read<ToleranceBloc>().selectTolerance(tolerance),
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
