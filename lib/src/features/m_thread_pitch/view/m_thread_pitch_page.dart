// Package imports:

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threadfon/src/common/constant/colors.dart';
import 'package:threadfon/src/common/data/m_thread_repository.dart';
import 'package:threadfon/src/common/localization/localization.dart';
import 'package:threadfon/src/common/styles/app_text_styles_extension.dart';
import 'package:threadfon/src/common/util/app_utils.dart';
import 'package:threadfon/src/common/widgets/my_divider.dart';
import 'package:threadfon/src/common/widgets/my_error_widget.dart';
import 'package:threadfon/src/common/widgets/my_load_widget.dart';
import 'package:threadfon/src/common/widgets/my_msg_widget.dart';
import 'package:threadfon/src/features/m_thread_tolerance/view/m_thread_tolerance_page.dart';
import 'package:threadfon/src/features/pitch/m_thread_pitch_model.dart';
import 'package:threadfon/src/features/threads/view/m_thread/cubit/m_thread_cubit.dart';

enum TypePitch { coarse, fine, superFine }

class MThreadPitchPage extends StatelessWidget {
  const MThreadPitchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = RepositoryProvider.of<MThreadRepository>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(Localization.of(context).thread_pitch),
      ),
      body: FutureBuilder(
        future: repository.fetchMPitch(context.read<MThreadCubit>().state.diam),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const MyLoadWidget();
            default:
              if (snapshot.hasError) {
                return MyErrorWidget(errorMsg: snapshot.error.toString());
              } else {
                if (snapshot.data == null) {
                  return const MyMsgWidget(msg: 'no data');
                } else {
                  return SingleChildScrollView(
                    // TODOfor ads
                    padding: const EdgeInsets.only(bottom: 120),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (snapshot.data!.isCoarse) _CoarsePitchWidget(pitchModel: snapshot.data!),
                        if (snapshot.data!.isFine) FinePitchWidget(pitchModel: snapshot.data!),
                        if (snapshot.data!.isSuperFine) SuperFinePitchWidget(pitchModel: snapshot.data!),
                      ],
                    ),
                  );
                }
              }
          }
        },
      ),
    );
  }
}

class FinePitchWidget extends StatelessWidget {
  const FinePitchWidget({required this.pitchModel, super.key});

  final MThreadPitchModel pitchModel;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const MyDivider(),
          _PitchTypeWidget(
            typePitch: Localization.of(context).thread_pitch_fine,
          ),
          for (final pitch in pitchModel.pitchsFine)
            _PitchItem(
              pitch: pitch,
              typePitch: TypePitch.fine,
            ),
        ],
      );
}

class SuperFinePitchWidget extends StatelessWidget {
  const SuperFinePitchWidget({required this.pitchModel, super.key});

  final MThreadPitchModel pitchModel;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const MyDivider(),
          _PitchTypeWidget(
            typePitch: Localization.of(context).thread_pitch_superfine,
          ),
          for (final pitch in pitchModel.pitchsSuperFine)
            _PitchItem(
              pitch: pitch,
              typePitch: TypePitch.superFine,
            ),
        ],
      );
}

class _CoarsePitchWidget extends StatelessWidget {
  const _CoarsePitchWidget({
    required this.pitchModel,
  });

  final MThreadPitchModel pitchModel;
  @override
  Widget build(BuildContext context) => Column(
        children: [
          _PitchTypeWidget(
            typePitch: Localization.of(context).thread_pitch_coarse,
          ),
          _PitchItem(
            pitch: pitchModel.pitchCoarse,
            typePitch: TypePitch.coarse,
          ),
        ],
      );
}

class _PitchTypeWidget extends StatelessWidget {
  const _PitchTypeWidget({
    required this.typePitch,
  });
  final String typePitch;
  @override
  Widget build(BuildContext context) => Text(
        typePitch,
  
      );
}

class _PitchItem extends StatelessWidget {
  const _PitchItem({
    required this.pitch,
    required this.typePitch,
  });
  final String pitch;
  final TypePitch typePitch;
  @override
  Widget build(BuildContext context) {
    final abrv = Localization.of(context).m_thread_abrv;
    final diam = context.read<MThreadCubit>().state.diam;
    return ListTile(
      contentPadding: const EdgeInsets.all(8),
      onTap: () {
        _selectedPitch(context, typePitch, pitch);
        if (AppUtilsParse.stringToDouble(diam) < 1) {
          // ScaffoldMessenger.of(context).showSnackBar(mySnakBarWidget(
          //     context: context, text: Localization.of(context)!.no_data));
          // log.i('show snack');

          _showMyDialog(context);

          return;
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MThreadTolerancePage(),
          ),
        );
      },
      title: Center(
        child: Text(
          '$abrv $diam x $pitch',
      
        ),
      ),
    );
  }

  void _selectedPitch(BuildContext context, TypePitch typePitch, String pitch) {
    final mThreadCubit = context.read<MThreadCubit>();

    mThreadCubit.setPitch(pitch);

    switch (typePitch) {
      case TypePitch.coarse:
        mThreadCubit.setCoarsePith();
      case TypePitch.fine:
        mThreadCubit.setFinePith();

      case TypePitch.superFine:
        mThreadCubit.setSuperFinePith();
    }
  }

  Future<void> _showMyDialog(BuildContext context) async {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;
    final backgroundColor = isDark ? ConstColor.neutral_grey_1000 : ConstColor.neutral_grey_100;

    return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: backgroundColor,
        title: Text(
          Localization.of(context).no_data,
          textAlign: TextAlign.center,
 
        ),
        // content: Text('This is a demo alert dialog.'),
      ),
    );
  }
}
