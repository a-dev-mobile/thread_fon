import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
import 'package:threadfon/features/03_metric_threads/info/bloc/metric_info_bloc.dart';
import 'package:threadfon/features/03_metric_threads/info/repositories/metric_info_repository.dart';
import 'package:threadfon/features/03_metric_threads/info/views/metric_full_screen_svg_view.dart';
import 'package:threadfon/features/03_metric_threads/info/views/metric_info_diameters_parameters.dart';
import 'package:threadfon/features/03_metric_threads/info/views/metric_info_main_parameters.dart';
import 'package:threadfon/features/03_metric_threads/info/views/metric_info_parameters.dart';
import 'package:threadfon/localization/generated/l10n.dart';
import 'package:threadfon/localization/l10n_extension.dart';

final LogService _logger = LogService('info_screen');

class MetricInfoScreen extends StatefulWidget {
  const MetricInfoScreen({super.key});
  static const String path = '/MetricInfoScreen';
  static const String name = 'MetricInfoScreen';

  @override
  State<MetricInfoScreen> createState() => _MetricInfoState();
}

class _MetricInfoState extends State<MetricInfoScreen> {
  late MetricInfoBloc _bloc;

  @override
  void initState() {
    super.initState();
    final ApiService apiService = context.read<ApiService>();
    final MetricInfoRepository infoRepository =
        MetricInfoRepository(apiService: apiService);
    final LocalStorage localStorage = context.read<LocalStorage>();
    final LanguageBloc languageBloc = context.read<LanguageBloc>();
    final ThemeBloc themeBloc = context.read<ThemeBloc>();

    _bloc = MetricInfoBloc(
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
    final MetricInfoBloc bloc = context.watch<MetricInfoBloc>();
    final MetricInfoState state = bloc.state;

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

    return BlocListener<MetricInfoBloc, MetricInfoState>(
      listenWhen: (MetricInfoState previous, MetricInfoState current) =>
          previous.enumNavigationStatus != current.enumNavigationStatus,
      listener: (BuildContext context, MetricInfoState state) async {
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
                    ? state.svgData ?? ''
                    : state.svgDataNoDimensions ?? '',
                svgRequestStatus: state.svgRequestStatus,
                svgErrorMsg: state.svgErrorMsg,
                overlayHeight: overlayHeight,
                svgAspectRatio: svgAspectRatio,
                svgWidth: svgWidth,
                svgHeight: svgHeight,
                onClose: () => bloc.toggleSvgOverlay(),
                onExpand: () {
                  final String? svgDataToSend = state.showDimensions
                      ? state.svgData
                      : state.svgDataNoDimensions;

                  if (svgDataToSend != null) {
                    context.pushNamed(MetricFullScreenSvgView.name,
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

  Widget _buildContent(MetricInfoBloc bloc, BuildContext context,
      double overlayHeight, double svgWidth, double svgHeight) {
    final MetricInfoState state = bloc.state;

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

  Widget _buildSuccessContent(BuildContext context, MetricInfoState state,
      MetricInfoBloc bloc, double overlayHeight) {
    final GeneratedLocalization localization = context.l10n;

    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: Text(localization.threads_info),
          floating: true,
          snap: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(FontAwesomeIcons.compassDrafting),
              onPressed: () => bloc.toggleSvgOverlay(),
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return UnitsPrecisionDialog(
                      units: state.units,
                      precision: state.precision,
                      onApply:
                          (EnumUnits selectedUnits, int selectedPrecision) {
                        bloc.updateUnitsPrecision(
                          units: selectedUnits,
                          precision: selectedPrecision,
                        );
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          sliver: SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              MetricInfoMainParameters(
                info: state.model!,
              ),
              const Divider(),
              MetricInfoDiametersParameters(
                info: state.model!,
              ),
              const Divider(),
              MetricInfoParameters(
                info: state.model!,
              ),
            ]),
          ),
        ),
        // Add extra space when overlay is visible
        if (state.isSvgOverlayVisible)
          SliverToBoxAdapter(
            child: SizedBox(
              height: overlayHeight,
            ),
          ),
      ],
    );
  }
}

class UnitsPrecisionDialog extends StatefulWidget {
  final EnumUnits units;
  final int precision;
  final void Function(EnumUnits units, int precision) onApply;

  const UnitsPrecisionDialog({
    required this.units,
    required this.precision,
    required this.onApply,
    super.key,
  });

  @override
  _UnitsPrecisionDialogState createState() => _UnitsPrecisionDialogState();
}

class _UnitsPrecisionDialogState extends State<UnitsPrecisionDialog> {
  late EnumUnits _selectedUnits;
  late int _selectedPrecision;

  @override
  void initState() {
    super.initState();
    _selectedUnits = widget.units;
    _selectedPrecision = widget.precision;
  }

  @override
  Widget build(BuildContext context) {
    final GeneratedLocalization localization = context.l10n;

    return AlertDialog(
      title: Text(localization.settings),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Units selection
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(localization.units),
              DropdownButton<EnumUnits>(
                value: _selectedUnits,
                items: EnumUnits.values.map((EnumUnits units) {
                  return DropdownMenuItem<EnumUnits>(
                    value: units,
                    child: Text(units == EnumUnits.mm
                        ? localization.mm
                        : localization.inch),
                  );
                }).toList(),
                onChanged: (EnumUnits? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedUnits = newValue;
                    });
                  }
                },
              ),
            ],
          ),
          // Precision selection
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(localization.precision),
              DropdownButton<int>(
                value: _selectedPrecision,
                items: <int>[1, 2, 3, 4, 5].map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
                onChanged: (int? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedPrecision = newValue;
                    });
                  }
                },
              ),
            ],
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => context.pop(),
          child: Text(localization.cancel),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onApply(_selectedUnits, _selectedPrecision);
            context.pop();
          },
          child: Text(localization.apply),
        ),
      ],
    );
  }
}
