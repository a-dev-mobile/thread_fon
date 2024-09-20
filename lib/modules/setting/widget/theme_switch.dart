import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/widgets/button/btn_list_switch.dart';
import '../cubit/toggle_theme_cubit.dart';

class ThemeSwitchWidget extends StatelessWidget {
  const ThemeSwitchWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocBuilder<ToggleThemeCubit, bool>(
        builder: (context, state) => BtnListSwitch(
          onChanged: (bool value) {
            context.read<ToggleThemeCubit>().toggleTheme(isDark: value);
          },
          value: state,
          leading: const Icon(Icons.brightness_6),
          text: AppLocalizations.of(context).dark_theme,
        ),
      );
}
