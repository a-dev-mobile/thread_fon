import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:threadfon/core/constant/enum_units.dart';
import 'package:threadfon/localization/generated/l10n.dart';
import 'package:threadfon/localization/l10n_extension.dart';

class ThreadInfoAppBar extends StatelessWidget {
  final bool hasSvgButton;
  final EnumUnits units;
  final int precision;
  final Function() onSvgToggle;
  final Function(EnumUnits, int) onUnitsPrecisionUpdate;

  const ThreadInfoAppBar({
    required this.hasSvgButton,
    required this.units,
    required this.precision,
    required this.onSvgToggle,
    required this.onUnitsPrecisionUpdate,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final GeneratedLocalization localization = context.l10n;

    return SliverAppBar(
      title: Text(
        localization.threads_info,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
      ),
      floating: true,
      snap: true,
      actions: <Widget>[
        if (hasSvgButton)
          IconButton(
            icon: const Icon(FontAwesomeIcons.compassDrafting),
            onPressed: onSvgToggle,
          ),
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return UnitsPrecisionDialog(
                  units: units,
                  precision: precision,
                  onApply: onUnitsPrecisionUpdate,
                );
              },
            );
          },
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
