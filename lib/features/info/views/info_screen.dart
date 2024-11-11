import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threadfon/app/language/language_bloc.dart';
import 'package:threadfon/app/theme/theme_bloc.dart';
import 'package:threadfon/core/constant/enum_navigation.dart';
import 'package:threadfon/core/constant/enum_status.dart';
import 'package:threadfon/core/services/api_service/api_service.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/core/widgets/blurred_overlay.dart';
import 'package:threadfon/core/widgets/my_error_widget.dart';
import 'package:threadfon/core/widgets/my_load_widget.dart';
import 'package:threadfon/features/info/bloc/info_bloc.dart';
import 'package:threadfon/features/info/repositories/info_repository.dart';
import 'package:threadfon/features/info/views/full_screen_svg_view.dart';
import 'package:threadfon/features/info/views/info_diameters_parameters.dart';
import 'package:threadfon/features/info/views/info_main_parameters.dart';
import 'package:threadfon/localization/l10n_extension.dart';

final _logger = LogService('info_screen');

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final apiService = context.read<ApiService>();
    final infoRepository = InfoRepository(apiService: apiService);
    final localStorage = context.read<LocalStorage>();
    final languageBloc = context.read<LanguageBloc>();
    final themeBloc = context.read<ThemeBloc>();

    return BlocProvider(
      create: (_) => InfoBloc(
        repository: infoRepository,
        localStorage: localStorage,
        languageBloc: languageBloc,
        themeBloc: themeBloc,
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
  Widget build(BuildContext context) {
    final localization = context.l10n;

    return BlocListener<InfoBloc, InfoState>(
      listenWhen: (previous, current) => previous.enumNavigationStatus != current.enumNavigationStatus,
      listener: (context, state) async {},
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<LanguageBloc>().toggle();
            context.read<ThemeBloc>().toggle();
            context.read<InfoBloc>().load();
          },
          child: const Icon(Icons.navigate_next),
        ),
        body: Stack(
          children: [
            BlocBuilder<InfoBloc, InfoState>(
              builder: (context, state) {
                switch (state.enumPageStatus) {
                  case EnumPageStatus.loading:
                  case EnumPageStatus.initial:
                    return const MyLoadWidget();

                  case EnumPageStatus.error:
                    return MyErrorWidget(
                      errorMsg: state.errorMsg,
                      onRetry: () => context.read<InfoBloc>().load(),
                    );
                  case EnumPageStatus.success:
                    if (state.model == null) {
                      return const Center(child: Text('No data available.'));
                    }

                    return CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          title: Text(localization.threads_info),
                          floating: true,
                          snap: true,
                          actions: [
                            IconButton(
                              icon: const Icon(FontAwesomeIcons.compassDrafting),
                              onPressed: () {
                                if (state.svgData != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FullScreenSvgView(
                                        svgData: state.svgData!,
                                        designation: state.model!.designation,
                                      ),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(localization.no_svg_data),
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          sliver: SliverList(
                            delegate: SliverChildListDelegate([
                              InfoMainParameters(
                                info: state.model!,
                              ),
                              Divider(),
                              InfoDiametersParameters(
                                info: state.model!,
                              ),
                              Divider(),
                            ]),
                          ),
                        ),
                      ],
                    );
                }
              },
            ),
            BlocBuilder<InfoBloc, InfoState>(
              builder: (context, state) {
                if (state.enumNavigationStatus.isPreparation) {
                  return const BlurredOverlay();
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
