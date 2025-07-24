import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:threadfon/app/language/language_bloc.dart';
import 'package:threadfon/app/theme/theme_bloc.dart';
import 'package:threadfon/core/constant/enum_navigation_status.dart';
import 'package:threadfon/core/constant/enum_status.dart';
import 'package:threadfon/core/constant/enum_units.dart';
import 'package:threadfon/core/services/api_service/api_service.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/core/widgets/loading_widget.dart';
import 'package:threadfon/core/widgets/my_error_widget.dart';
import 'package:threadfon/core/widgets/svg_overlay.dart';
import 'package:threadfon/core/widgets/thread_info_app_bar.dart';
import 'package:threadfon/features/06_pipe_threads/info/bloc/pipe_info_bloc.dart';
import 'package:threadfon/features/06_pipe_threads/info/repositories/pipe_info_repository.dart';
import 'package:threadfon/features/06_pipe_threads/info/views/full_screen_svg_view.dart';
import 'package:threadfon/features/06_pipe_threads/info/views/pipe_additional_info.dart';
import 'package:threadfon/features/06_pipe_threads/info/views/pipe_diameters_info.dart';
import 'package:threadfon/features/06_pipe_threads/info/views/pipe_main_info.dart';

final LogService _logger = LogService('info_screen');

class PipeInfoScreen extends StatefulWidget {
  const PipeInfoScreen({super.key});
  static const String path = '/PipeInfoScreen';
  static const String name = 'PipeInfoScreen';

  @override
  State<PipeInfoScreen> createState() => _PipeInfoScreenState();
}

class _PipeInfoScreenState extends State<PipeInfoScreen> {
  late PipeInfoBloc _bloc;

  @override
  void initState() {
    super.initState();
    final ApiService apiService = context.read<ApiService>();
    final PipeInfoRepository infoRepository = PipeInfoRepository(
      apiService: apiService,
    );
    final LocalStorage localStorage = context.read<LocalStorage>();
    final LanguageBloc languageBloc = context.read<LanguageBloc>();
    final ThemeBloc themeBloc = context.read<ThemeBloc>();

    _bloc = PipeInfoBloc(
      repository: infoRepository,
      localStorage: localStorage,
      languageBloc: languageBloc,
      themeBloc: themeBloc,
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => _bloc, child: const _PipePipeInfoView());
  }
}

class _PipePipeInfoView extends StatefulWidget {
  const _PipePipeInfoView();

  @override
  State<_PipePipeInfoView> createState() => _PipePipeInfoViewState();
}

class _PipePipeInfoViewState extends State<_PipePipeInfoView> {
  @override
  Widget build(BuildContext context) {
    final PipeInfoBloc bloc = context.watch<PipeInfoBloc>();
    final PipeInfoState state = bloc.state;

    // Screen dimensions
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    const double svgWidth = 785.0;
    const double svgHeight = 568.0;
    const double svgAspectRatio = svgWidth / svgHeight;
    final double calculatedOverlayHeight = screenWidth / svgAspectRatio;
    final double maxOverlayHeight = screenHeight * 0.4;
    final double overlayHeight = calculatedOverlayHeight > maxOverlayHeight
        ? maxOverlayHeight
        : calculatedOverlayHeight;

    return BlocListener<PipeInfoBloc, PipeInfoState>(
      listenWhen: (PipeInfoState previous, PipeInfoState current) =>
          previous.enumNavigationStatus != current.enumNavigationStatus,
      listener: (BuildContext context, PipeInfoState state) async {
        // Handle side effects if needed
      },
      child: Scaffold(
        body: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            // Main content
            _buildContent(bloc, context, overlayHeight, svgWidth, svgHeight),
            // SVG Overlay
            if (state.isSvgOverlayVisible)
              SvgOverlay(
                svgData: state.showDimensions
                    ? state.svgDimensions ?? ''
                    : state.svgAnnotations ?? '',
                svgRequestStatus: state.svgRequestStatus,
                svgErrorMsg: state.svgErrorMsg,
                overlayHeight: overlayHeight,
                svgAspectRatio: svgAspectRatio,
                svgWidth: svgWidth,
                svgHeight: svgHeight,
                onClose: () => bloc.toggleSvgOverlay(),
                onExpand: () {
                  final String? svgDataToSend = state.showDimensions
                      ? state.svgDimensions
                      : state.svgAnnotations;

                  if (svgDataToSend != null) {
                    context.pushNamed(
                      PipeFullScreenSvgView.name,
                      extra: <String, String>{'svgData': svgDataToSend},
                    );
                  } else {
                    // Handle the null case, perhaps show an error or a placeholder
                    _logger.e('SVG data is null when trying to expand');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('SVG data is unavailable.')),
                    );
                  }
                },
                onSwitchSvg: () => bloc.toggleDimensions(),
                showDimensions: state.showDimensions,
              ),
            // Blurred overlay when in preparation status
            if (state.enumNavigationStatus.isPreparation)
              const LoadingWidget(isBlurred: true),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(
    PipeInfoBloc bloc,
    BuildContext context,
    double overlayHeight,
    double svgWidth,
    double svgHeight,
  ) {
    final PipeInfoState state = bloc.state;

    switch (state.enumPageStatus) {
      case EnumStatus.loading:
        return const Center(child: LoadingWidget());

      case EnumStatus.error:
        return MyErrorWidget(
          errorMsg: state.errorMsg ?? 'An unknown error occurred.',
          onRetry: () {
            bloc.load();
          },
        );

      case EnumStatus.success:
        return _buildSuccessContent(context, state, bloc, overlayHeight);
    }
  }

  Widget _buildSuccessContent(
    BuildContext context,
    PipeInfoState state,
    PipeInfoBloc bloc,
    double overlayHeight,
  ) {
    return CustomScrollView(
      slivers: <Widget>[
        ThreadInfoAppBar(
          hasSvgButton: false,
          units: state.units,
          precision: state.precision,
          onSvgToggle: () => bloc.toggleSvgOverlay(),
          onUnitsPrecisionUpdate: (EnumUnits units, int precision) =>
              bloc.updateUnitsPrecision(units: units, precision: precision),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          sliver: SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              PipeInfoMainParameters(info: state.model!),
              const Divider(),
              PipeInfoDiametersParameters(info: state.model!),
              const Divider(),
              PipeAdditionalInfo(list: state.model!.additional_info),
            ]),
          ),
        ),
        // Add extra space when overlay is visible
        if (state.isSvgOverlayVisible)
          SliverToBoxAdapter(child: SizedBox(height: overlayHeight)),
      ],
    );
  }
}
