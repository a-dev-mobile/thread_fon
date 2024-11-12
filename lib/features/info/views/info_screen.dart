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
import 'package:threadfon/core/widgets/svg_overlay.dart';
import 'package:threadfon/features/info/bloc/info_bloc.dart';
import 'package:threadfon/features/info/repositories/info_repository.dart';
import 'package:threadfon/features/info/views/full_screen_svg_view.dart';
import 'package:threadfon/features/info/views/info_diameters_parameters.dart';
import 'package:threadfon/features/info/views/info_main_parameters.dart';
import 'package:threadfon/localization/l10n_extension.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_view/photo_view.dart';
import 'package:threadfon/src/common/localization/generated/l10n.dart';

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
  bool _isSvgOverlayVisible = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final svgWidth = 785.0;
    final svgHeight = 568.0;
    final svgAspectRatio = svgWidth / svgHeight;
    final calculatedOverlayHeight = screenWidth / svgAspectRatio;
    final maxOverlayHeight = screenHeight * 0.4;
    final overlayHeight = calculatedOverlayHeight > maxOverlayHeight ? maxOverlayHeight : calculatedOverlayHeight;

    final state = context.watch<InfoBloc>().state;

    return BlocListener<InfoBloc, InfoState>(
      listenWhen: (previous, current) => previous.enumNavigationStatus != current.enumNavigationStatus,
      listener: (context, state) async {
        // Handle side effects if needed
      },
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
          clipBehavior: Clip.none, 
          children: [
            // Main scrollable content
            _buildMainContent(state, context, overlayHeight, svgWidth, svgHeight),
            // SVG Overlay
            if (_isSvgOverlayVisible && state.svgData != null)
              SvgOverlay(
                svgData: state.svgData!,
                overlayHeight: overlayHeight,
                svgAspectRatio: svgAspectRatio,
                svgWidth: svgWidth,
                svgHeight: svgHeight,
                onClose: () {
                  setState(() {
                    _isSvgOverlayVisible = false;
                  });
                },
                onExpand: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FullScreenSvgView(svgData: state.svgData!),
                    ),
                  );
                },
              ),
            // Blurred overlay when in preparation status
            if (state.enumNavigationStatus.isPreparation) const BlurredOverlay(),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContent(
      InfoState state, BuildContext context, double overlayHeight, double svgWidth, double svgHeight) {
    final localization = context.l10n;
    switch (state.enumPageStatus) {
      case EnumPageStatus.loading:
      case EnumPageStatus.initial:
        return const Center(child: MyLoadWidget());

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
                      setState(() {
                        _isSvgOverlayVisible = !_isSvgOverlayVisible;
                      });
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
                  const Divider(),
                  InfoDiametersParameters(
                    info: state.model!,
                  ),
                  const Divider(),
                ]),
              ),
            ),
            // Add extra space when overlay is visible
            if (_isSvgOverlayVisible)
              SliverToBoxAdapter(
                child: SizedBox(
                  height: overlayHeight,
                ),
              ),
          ],
        );
    }
  }
}
