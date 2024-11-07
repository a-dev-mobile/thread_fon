import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:threadfon/app/language/language_bloc.dart';
import 'package:threadfon/app/theme/theme_bloc.dart';
import 'package:threadfon/core/constant/enum_status.dart';
import 'package:threadfon/core/services/api_service/api_service.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/core/widgets/my_error_widget.dart';
import 'package:threadfon/core/widgets/my_load_widget.dart';
import 'package:threadfon/features/info/bloc/info_bloc.dart';
import 'package:threadfon/features/info/repositories/info_repository.dart';
import 'package:threadfon/features/info/views/info_diameters_parameters.dart';
import 'package:threadfon/features/info/views/info_main_parameters.dart';
import 'package:threadfon/localization/l10n.dart';

final _logger = LogService('info_screen');

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

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
  Widget build(BuildContext context) {
    final localization = context.l10n;

    return BlocListener<InfoBloc, InfoState>(
      listenWhen: (previous, current) => previous.status != current.status,
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

                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      title: Text(localization.threads_info),
                      floating: true, // Позволяет AppBar появляться при прокрутке вверх
                      snap: true, // Анимация появления AppBar
                      // pinned: false, // Если установить true, AppBar будет частично видим при прокрутке вниз
                      // можно добавить другие параметры по необходимости
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(vertical:  16.0),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                          InfoMainParameters(
                            info: state.model!,
                        
                          ),
                          Divider() ,
                          InteractiveViewer(
              
                            minScale: 0.5,
                            maxScale: 10.0,
                            child: Builder(builder: (context) {
                              final isDark = context.select((ThemeBloc bloc) => bloc.state.themeMode == ThemeMode.dark);
                              return SvgPicture.string(
                                state.svgData!,
                                color: isDark ? Colors.white : null,
                                fit: BoxFit.contain,
                              );
                            }),
                          ),
                          InfoDiametersParameters(
                            info: state.model!,
                          ),
                                 Divider(),
                                 Divider(),
                          
                          
                        ]),
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
