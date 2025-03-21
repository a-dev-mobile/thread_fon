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
import 'package:threadfon/features/04_imperial_threads/info/bloc/imperial_info_bloc.dart';
import 'package:threadfon/features/04_imperial_threads/info/repositories/imperial_info_repository.dart';
import 'package:threadfon/features/04_imperial_threads/info/views/full_screen_svg_view.dart';
import 'package:threadfon/features/04_imperial_threads/info/views/imperial_additional_info.dart';
import 'package:threadfon/features/04_imperial_threads/info/views/imperial_info_diameters_parameters.dart';
import 'package:threadfon/features/04_imperial_threads/info/views/imperial_info_main_parameters.dart';

final LogService _logger = LogService('info_screen');

class ImperialInfoScreen extends StatefulWidget {
  const ImperialInfoScreen({super.key});
  static const String path = '/ImperialInfoScreen';
  static const String name = 'ImperialInfoScreen';

  @override
  State<ImperialInfoScreen> createState() => _ImperialInfoScreenState();
}

class _ImperialInfoScreenState extends State<ImperialInfoScreen> {
  late ImperialInfoBloc _bloc;

  @override
  void initState() {
    super.initState();
    final ApiService apiService = context.read<ApiService>();
    final ImperialInfoRepository infoRepository =
        ImperialInfoRepository(apiService: apiService);
    final LocalStorage localStorage = context.read<LocalStorage>();
    final LanguageBloc languageBloc = context.read<LanguageBloc>();
    final ThemeBloc themeBloc = context.read<ThemeBloc>();

    _bloc = ImperialInfoBloc(
      repository: infoRepository,
      localStorage: localStorage,
      languageBloc: languageBloc,
      themeBloc: themeBloc,
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _bloc,
      child: const _ImperialInfoView(),
    );
  }
}

class _ImperialInfoView extends StatefulWidget {
  const _ImperialInfoView();

  @override
  State<_ImperialInfoView> createState() => _ImperialInfoViewState();
}

class _ImperialInfoViewState extends State<_ImperialInfoView> {
  @override
  Widget build(BuildContext context) {
    final ImperialInfoBloc bloc = context.watch<ImperialInfoBloc>();
    final ImperialInfoState state = bloc.state;

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

    return BlocListener<ImperialInfoBloc, ImperialInfoState>(
      listenWhen: (ImperialInfoState previous, ImperialInfoState current) =>
          previous.enumNavigationStatus != current.enumNavigationStatus,
      listener: (BuildContext context, ImperialInfoState state) async {
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
                    context.pushNamed(ImperialFullScreenSvgView.name,
                        extra: <String, String>{
                          'svgData': svgDataToSend,
                        });
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

  Widget _buildContent(ImperialInfoBloc bloc, BuildContext context,
      double overlayHeight, double svgWidth, double svgHeight) {
    final ImperialInfoState state = bloc.state;

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

  Widget _buildSuccessContent(BuildContext context, ImperialInfoState state,
      ImperialInfoBloc bloc, double overlayHeight) {
    return CustomScrollView(
      slivers: <Widget>[
        ThreadInfoAppBar(
          hasSvgButton: false, // SVG not implemented for imperial
          units: state.units,
          precision: state.precision,
          onSvgToggle: () => bloc.toggleSvgOverlay(),
          onUnitsPrecisionUpdate: (EnumUnits units, int precision) =>
              bloc.updateUnitsPrecision(
            units: units,
            precision: precision,
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          sliver: SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              ImperialInfoMainParameters(
                info: state.model!,
              ),
              const Divider(),
              ImperialInfoDiametersParameters(
                info: state.model!,
              ),
              const Divider(),
              ImperialAdditionalInfo(
                list: state.model!.additional_info,
              ),
            ]),
          ),
        ),
        // Add extra space when overlay is visible
        if (state.isSvgOverlayVisible)
          SliverToBoxAdapter(
            child: SizedBox(height: overlayHeight),
          ),
      ],
    );
  }
}
