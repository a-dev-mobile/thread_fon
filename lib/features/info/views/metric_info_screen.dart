import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:threadfon/app/language/language_bloc.dart';
import 'package:threadfon/app/theme/theme_bloc.dart';
import 'package:threadfon/core/constant/enum_screen_status.dart';
import 'package:threadfon/core/constant/enum_status.dart';
import 'package:threadfon/core/services/api_service/api_service.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/core/widgets/my_error_widget.dart';
import 'package:threadfon/core/widgets/my_load_widget.dart';
import 'package:threadfon/features/diameter_selection/views/metric_diameter_screen.dart';
import 'package:threadfon/features/info/bloc/info_bloc.dart';
import 'package:threadfon/features/info/repositories/info_repository.dart';
import 'package:threadfon/features/info/views/info_choice_card.dart';
import 'package:threadfon/features/info/views/info_display_card.dart';
import 'package:threadfon/features/pitch_selection/views/pitch_selection_screen.dart';
import 'package:threadfon/localization/l10n.dart';

final _logger = LogService('metric_info_screen');

class MetricInfoScreen extends StatelessWidget {
  const MetricInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final apiService = context.read<ApiService>();
    final infoRepository = InfoRepository(apiService: apiService);
    final localStorage = context.read<LocalStorage>();
    final languageBloc = context.read<LanguageBloc>();

    return BlocProvider(
      create: (_) => InfoBloc(
        repository: infoRepository,
        localStorage: localStorage,
        languageBloc: languageBloc,
      )..load(),
      child: const _MetricInfoView(),
    );
  }
}

class _MetricInfoView extends StatefulWidget {
  const _MetricInfoView();

  @override
  State<_MetricInfoView> createState() => _MetricInfoViewState();
}

class _MetricInfoViewState extends State<_MetricInfoView> {


  @override
  void initState() {
    super.initState();
 
  }






  @override
  Widget build(BuildContext context) {
    final localization = context.l10n;

    return BlocListener<InfoBloc, InfoState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) async {
    
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(localization.threads_info),
        ),
        body: BlocBuilder<InfoBloc, InfoState>(
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
                  onRetry: () => context.read<InfoBloc>().load(),
                );
              case EnumStatus.success:
                if (state.model == null) {
                  return const Center(child: Text('No data available.'));
                }

                return Column(
                  children: [
                    InfoDisplayCard(
                      info: state.model!,
                      onTap: () => context.read<InfoBloc>().selectInfo(),
                    ),
                    Expanded(
                      child: state.svgData == null
                          ? const Center(child: CircularProgressIndicator())
                          : InteractiveViewer(
                              minScale: 0.5,
                              maxScale: 10.0,
                              child: Builder(builder: (context) {
                                final isDark = context.select((ThemeBloc bloc) =>
                                    bloc.state.themeMode == ThemeMode.dark);
                                return SvgPicture.string(
                                  state.svgData!,
                                  color: isDark ? Colors.white : null,
                               
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
      ),
    );
  }
}
