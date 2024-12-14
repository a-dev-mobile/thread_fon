import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:threadfon/app/language/language_bloc.dart';
import 'package:threadfon/app/theme/theme_bloc.dart';
import 'package:threadfon/core/constant/enum_navigation.dart';
import 'package:threadfon/core/constant/enum_status.dart';
import 'package:threadfon/core/constant/enum_units.dart';
import 'package:threadfon/core/services/api_service/api_service.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/core/widgets/loading_widget.dart';
import 'package:threadfon/core/widgets/my_error_widget.dart';
import 'package:threadfon/core/widgets/svg_overlay.dart';
import 'package:threadfon/features/imperial_threads/info/bloc/imperial_info_bloc.dart';

import 'package:threadfon/features/imperial_threads/info/repositories/imperial_info_repository.dart';
import 'package:threadfon/features/imperial_threads/info/views/full_screen_svg_view.dart';
import 'package:threadfon/features/imperial_threads/info/views/imperial_info_diameters_parameters.dart';
import 'package:threadfon/features/imperial_threads/info/views/imperial_info_main_parameters.dart';
import 'package:threadfon/features/imperial_threads/info/views/imperial_info_parameters.dart';
import 'package:threadfon/localization/l10n_extension.dart';

final _logger = LogService('info_screen');

class ImperialInfoScreen extends StatefulWidget {
  const ImperialInfoScreen({super.key});
  static const path = '/ImperialInfoScreen';
  static const name = 'ImperialInfoScreen';

  @override
  State<ImperialInfoScreen> createState() => _ImperialInfoScreenState();
}

class _ImperialInfoScreenState extends State<ImperialInfoScreen> {
  late ImperialInfoBloc _bloc;

  @override
  void initState() {
    super.initState();
    final apiService = context.read<ApiService>();
    final infoRepository = ImperialInfoRepository(apiService: apiService);
    final localStorage = context.read<LocalStorage>();
    final languageBloc = context.read<LanguageBloc>();
    final themeBloc = context.read<ThemeBloc>();

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
      child: const _ImperialImperialInfoView(),
    );
  }
}

class _ImperialImperialInfoView extends StatefulWidget {
  const _ImperialImperialInfoView();

  @override
  State<_ImperialImperialInfoView> createState() =>
      _ImperialImperialInfoViewState();
}

class _ImperialImperialInfoViewState extends State<_ImperialImperialInfoView> {
  bool _isSvgOverlayVisible = true;
  bool _showDimensions = true;

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ImperialInfoBloc>();
    final state = bloc.state;

    // Screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final svgWidth = 785.0;
    final svgHeight = 568.0;
    final svgAspectRatio = svgWidth / svgHeight;
    final calculatedOverlayHeight = screenWidth / svgAspectRatio;
    final maxOverlayHeight = screenHeight * 0.4;
    final overlayHeight = calculatedOverlayHeight > maxOverlayHeight
        ? maxOverlayHeight
        : calculatedOverlayHeight;

    return BlocListener<ImperialInfoBloc, ImperialInfoState>(
      listenWhen: (previous, current) =>
          previous.enumNavigationStatus != current.enumNavigationStatus,
      listener: (context, state) async {
        // Handle side effects if needed
      },
      child: Scaffold(
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            // Main content
            _buildContent(bloc, context, overlayHeight, svgWidth, svgHeight),
            // SVG Overlay
            if (_isSvgOverlayVisible)
              SvgOverlay(
                svgData: _showDimensions
                    ? state.svgData ?? ''
                    : state.svgDataNoDimensions ?? '',
                svgRequestStatus: state.svgRequestStatus,
                svgErrorMsg: state.svgErrorMsg,
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
                  final svgDataToSend = _showDimensions
                      ? state.svgData
                      : state.svgDataNoDimensions;

                  if (svgDataToSend != null) {
                    context.pushNamed(ImperialFullScreenSvgView.name, extra: {
                      'svgData': svgDataToSend,
                    });
                  } else {
                    // Handle the null case, perhaps show an error or a placeholder
                    _logger.e('SVG data is null when trying to expand');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('SVG data is unavailable.')),
                    );
                  }
                },
                onSwitchSvg: () {
                  setState(() {
                    _showDimensions = !_showDimensions;
                  });
                },
                showDimensions: _showDimensions,
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
    final state = bloc.state;

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
    final localization = context.l10n;
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
                setState(() {
                  _isSvgOverlayVisible = !_isSvgOverlayVisible;
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return UnitsPrecisionDialog(
                      units: state.units,
                      precision: state.precision,
                      onApply: (selectedUnits, selectedPrecision) {
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
            delegate: SliverChildListDelegate([
              ImperialInfoMainParameters(
                info: state.model!,
              ),
              const Divider(),
              ImperialInfoDiametersParameters(
                info: state.model!,
              ),
              const Divider(),
              ImperialInfoParameters(
                info: state.model!,
              ),
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

class UnitsPrecisionDialog extends StatefulWidget {
  final EnumUnits units;
  final int precision;
  final void Function(EnumUnits units, int precision) onApply;

  const UnitsPrecisionDialog({
    super.key,
    required this.units,
    required this.precision,
    required this.onApply,
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
    final localization = context.l10n;
    return AlertDialog(
      title: Text(localization.settings),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Units selection
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
            children: [
              Text(localization.precision),
              DropdownButton<int>(
                value: _selectedPrecision,
                items: [1, 2, 3, 4, 5].map((int value) {
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
      actions: [
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
