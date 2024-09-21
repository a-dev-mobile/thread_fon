import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threadfon/core/widgets/button/btn_list_switch.dart';
import 'package:threadfon/modules/setting/cubit/toggle_theme_cubit.dart';
import 'package:threadfon/src/common/localization/localization.dart';

class ThemeSwitchWidget extends StatelessWidget {
  const ThemeSwitchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) => BlocBuilder<ToggleThemeCubit, bool>(
        builder: (context, state) => BtnListSwitch(
          onChanged: (bool value) {
            context.read<ToggleThemeCubit>().toggleTheme(isDark: value);
          },
          value: state,
          leading: const Icon(Icons.brightness_6),
          text: Localization.of(context).dark_theme,
        ),
      );
}
