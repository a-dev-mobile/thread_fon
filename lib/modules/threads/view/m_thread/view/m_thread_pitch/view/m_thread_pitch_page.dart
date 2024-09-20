// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:threadfon/modules/threads/view/m_thread/view/m_thread_tolerance/view/m_thread_tolerance_page.dart';


import '../../../../../../../config/styles/app_text_style.dart';
import '../../../../../../../core/constants/colors.dart';
import '../../../../../../../core/utils/app_utils.dart';
import '../../../../../../../core/widgets/my_divider.dart';
import '../../../../../../../core/widgets/my_error_widget.dart';
import '../../../../../../../core/widgets/my_load_widget.dart';
import '../../../../../../../core/widgets/my_msg_widget.dart';
import '../../../../../../../data/m_thread/m_thread_repository.dart';
import '../../../../../../../data/m_thread/models/pitch/m_thread_pitch_model.dart';
import '../../../cubit/m_thread_cubit.dart';

enum TypePitch { coarse, fine, superFine }

class MThreadPitchPage extends StatelessWidget {
  const MThreadPitchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final repository = RepositoryProvider.of<MThreadRepository>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).thread_pitch),
      ),
      body: FutureBuilder(
        future: repository.fetchMPitch(context.read<MThreadCubit>().state.diam),
        builder: (context, AsyncSnapshot<MThreadPitchModel> snapshot) {
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
                    // TODO for ads
                    padding: EdgeInsets.only(bottom: 120.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (snapshot.data!.isCoarse)
                          _CoarsePitchWidget(pitchModel: snapshot.data!),
                        if (snapshot.data!.isFine)
                          FinePitchWidget(pitchModel: snapshot.data!),
                        if (snapshot.data!.isSuperFine)
                          SuperFinePitchWidget(pitchModel: snapshot.data!),
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
  const FinePitchWidget({Key? key, required this.pitchModel}) : super(key: key);

  final MThreadPitchModel pitchModel;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const MyDivider(),
          _PitchTypeWidget(
            typePitch: AppLocalizations.of(context).thread_pitch_fine,
          ),
          for (var pitch in pitchModel.pitchsFine)
            _PitchItem(
              pitch: pitch,
              typePitch: TypePitch.fine,
            ),
        ],
      );
}

class SuperFinePitchWidget extends StatelessWidget {
  const SuperFinePitchWidget({Key? key, required this.pitchModel})
      : super(key: key);

  final MThreadPitchModel pitchModel;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const MyDivider(),
          _PitchTypeWidget(
            typePitch: AppLocalizations.of(context).thread_pitch_superfine,
          ),
          for (var pitch in pitchModel.pitchsSuperFine)
            _PitchItem(
              pitch: pitch,
              typePitch: TypePitch.superFine,
            ),
        ],
      );
}

class _CoarsePitchWidget extends StatelessWidget {
  const _CoarsePitchWidget({
    Key? key,
    required this.pitchModel,
  }) : super(key: key);

  final MThreadPitchModel pitchModel;
  @override
  Widget build(BuildContext context) => Column(
        children: [
          _PitchTypeWidget(
            typePitch: AppLocalizations.of(context).thread_pitch_coarse,
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
    Key? key,
    required this.typePitch,
  }) : super(key: key);
  final String typePitch;
  @override
  Widget build(BuildContext context) => Text(
        typePitch,
        style: AppTextStyle.LABEL_REGULAR(),
      );
}

class _PitchItem extends StatelessWidget {
  const _PitchItem({
    Key? key,
    required this.pitch,
    required this.typePitch,
  }) : super(key: key);
  final String pitch;
  final TypePitch typePitch;
  @override
  Widget build(BuildContext context) {
    final abrv = AppLocalizations.of(context).m_thread_abrv;
    final diam = context.read<MThreadCubit>().state.diam;
    return ListTile(
      contentPadding: const EdgeInsets.all(8),
      onTap: () {
        _selectedPitch(context, typePitch, pitch);
        if (AppUtilsParse.stringToDouble(diam) < 1) {
          // ScaffoldMessenger.of(context).showSnackBar(mySnakBarWidget(
          //     context: context, text: AppLocalizations.of(context)!.no_data));
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
          style: AppTextStyle.H2(),
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
        break;
      case TypePitch.fine:
        mThreadCubit.setFinePith();
        break;

      case TypePitch.superFine:
        mThreadCubit.setSuperFinePith();
        break;
    }
  }

  Future<void> _showMyDialog(BuildContext context) async {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;
    final backgroundColor =
        isDark ? ConstColor.neutral_grey_1000 : ConstColor.neutral_grey_100;

    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: backgroundColor,
        title: Text(
          AppLocalizations.of(context).no_data,
          textAlign: TextAlign.center,
          style: AppTextStyle.H3_REGULAR(
            // colorText: Theme.of(context).textTheme.bodyText1!.color,
          ),
        ),
        // content: Text('This is a demo alert dialog.'),
      ),
    );
  }
}
