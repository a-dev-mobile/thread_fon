import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threadfon/src/common/constant/colors.dart';
import 'package:threadfon/src/common/constant/common.dart';
import 'package:threadfon/src/common/localization/localization.dart';
import 'package:threadfon/src/common/util/app_utils.dart';
import 'package:threadfon/src/common/widgets/my_divider.dart';
import 'package:threadfon/src/features/m_thread_info/cubit/m_thread_info_cubit.dart';
import 'package:threadfon/src/features/m_thread_info/view/widgets/female/m_thread_info_female_image.dart';
import 'package:threadfon/src/features/m_thread_info/view/widgets/male/m_thread_info_male_image.dart';
import 'package:threadfon/src/features/setting/setting_page.dart';
import 'package:threadfon/src/features/threads/view/m_thread/cubit/m_thread_cubit.dart';
import 'package:threadfon/src/features/threads/view/m_thread/models/models.dart';

class MThreadInfoPage extends StatelessWidget {
  const MThreadInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mThreadModel = context.read<MThreadCubit>().state;

    return BlocProvider<MThreadInfoCubit>(
      create: (context) => MThreadInfoCubit(),
      child: _MThreadInfoPage(mThreadModel: mThreadModel),
    );
  }
}

class _MThreadInfoPage extends StatelessWidget {
  const _MThreadInfoPage({
    required this.mThreadModel,
  });

  final MThreadModel mThreadModel;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(Localization.of(context).threads_info),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.settings))
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 120),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const UnitsSegmentControl(),
              //обозначение резьбы
              ThreadCaptionItem(
                text: Localization.of(context).thread_designation,
              ),
              // М35 х1
              const ThreadDeignationWidget(),
              //метрическая / мелкий шаг
              ThreadSubInfo(model: mThreadModel),
              const MyDivider(),
              BasicThreadParametersItem(
                title: Localization.of(context).thread_diam_nom,
                value:
                    context.watch<MThreadInfoCubit>().diam(mThreadModel.diam),
              ),
              BasicThreadParametersItem(
                title: Localization.of(context).thread_pitch,
                value:
                    context.watch<MThreadInfoCubit>().pitch(mThreadModel.pitch),
              ),
              // глубина резьбы
              BasicThreadParametersItem(
                title: Localization.of(context).thread_depth,
                value: context.watch<MThreadInfoCubit>().depth(
                      isMale: mThreadModel.isMale,
                      diam: mThreadModel.diam,
                      pitch: mThreadModel.pitch,
                    ),
              ),
              BasicThreadParametersItem(
                title: Localization.of(context).thread_class_tolerance,
                value: mThreadModel.tolerance,
              ),
              const MyDivider(),
              // image
              if (mThreadModel.isMale)
                InteractiveViewer(child: _MaleImage(mThreadModel: mThreadModel))
              else
                InteractiveViewer(
                  child: _FemaleImage(mThreadModel: mThreadModel),
                ),

              const MyDivider(),

              // внутренний наружний диам
              ThreadCaptionItem(
                text: mThreadModel.isMale
                    ? Localization.of(context).diam_major
                    : Localization.of(context).diam_minor,
              ),
              // допуск наружний
              ThreadTolerancesItem(
                title: Localization.of(context).thread_tolerance,
                value: context.watch<MThreadInfoCubit>().minorMajorDiam(
                      isMale: mThreadModel.isMale,
                      diameter: mThreadModel.diam,
                      pitch: mThreadModel.pitch,
                    ),
                top:
                    context.watch<MThreadInfoCubit>().minorMajorDiamToleranceEs(
                          isMale: mThreadModel.isMale,
                          es_d: mThreadModel.es_d,
                          es_d1: mThreadModel.es_d1,
                        ),
                bottom:
                    context.watch<MThreadInfoCubit>().minorMajorDiamToleranceEi(
                          isMale: mThreadModel.isMale,
                          ei_d: mThreadModel.ei_d,
                          ei_d1: mThreadModel.ei_d1,
                        ),
              ),
              ThreadMinMaxMeanItem(
                max: context.watch<MThreadInfoCubit>().minorMajorDiamMax(
                      diamS: mThreadModel.diam,
                      isMale: mThreadModel.isMale,
                      pitch: mThreadModel.pitch,
                      es_d: mThreadModel.es_d,
                      es_d1: mThreadModel.es_d1,
                    ),
                mean: context.watch<MThreadInfoCubit>().minorMajorDiamMean(
                      diamS: mThreadModel.diam,
                      isMale: mThreadModel.isMale,
                      pitch: mThreadModel.pitch,
                      es_d: mThreadModel.es_d,
                      es_d1: mThreadModel.es_d1,
                      ei_d: mThreadModel.ei_d,
                      ei_d1: mThreadModel.ei_d1,
                    ),
                min: context.watch<MThreadInfoCubit>().minorMajorDiamMin(
                      diam: mThreadModel.diam,
                      isMale: mThreadModel.isMale,
                      pitch: mThreadModel.pitch,
                      ei_d: mThreadModel.ei_d,
                      ei_d1: mThreadModel.ei_d1,
                    ),
              ),

              // допуск средний
              const MyDivider(),
              ThreadCaptionItem(
                text: Localization.of(context).diam_middle,
              ),

              ThreadTolerancesItem(
                title: Localization.of(context).diam_middle,
                value: context.watch<MThreadInfoCubit>().middleDiam(
                      diam: mThreadModel.diam,
                      pitch: mThreadModel.pitch,
                    ),
                top: context
                    .watch<MThreadInfoCubit>()
                    .middleDiamToleranceEs(es_d2: mThreadModel.es_d2),
                bottom: context
                    .watch<MThreadInfoCubit>()
                    .middleDiamToleranceEi(ei_d2: mThreadModel.ei_d2),
              ),
              ThreadMinMaxMeanItem(
                max: context.watch<MThreadInfoCubit>().middleDiamMax(
                      diam: mThreadModel.diam,
                      pitch: mThreadModel.pitch,
                      es_d2: mThreadModel.es_d2,
                    ),
                mean: context.watch<MThreadInfoCubit>().middleDiamMean(
                      diam: mThreadModel.diam,
                      pitch: mThreadModel.pitch,
                      es_d2: mThreadModel.es_d2,
                      ei_d2: mThreadModel.ei_d2,
                    ),
                min: context.watch<MThreadInfoCubit>().middleDiamMin(
                      diam: mThreadModel.diam,
                      pitch: mThreadModel.pitch,
                      ei_d2: mThreadModel.ei_d2,
                    ),
              ),

              // внутренний наружний диам
              const MyDivider(),
              ThreadCaptionItem(
                text: mThreadModel.isMale
                    ? Localization.of(context).diam_minor
                    : Localization.of(context).diam_major,
              ),

              ThreadTolerancesItem(
                title: Localization.of(context).thread_tolerance,
                value: context.watch<MThreadInfoCubit>().minorMajorDiamSub(
                      isMale: mThreadModel.isMale,
                      diameter: mThreadModel.diam,
                      pitch: mThreadModel.pitch,
                    ),
                top:
                    context.watch<MThreadInfoCubit>().minorMajorDiamToleranceEs(
                          isMale: mThreadModel.isMale,
                          es_d: mThreadModel.es_d,
                          es_d1: mThreadModel.es_d1,
                        ),
                bottom:
                    context.watch<MThreadInfoCubit>().minorMajorDiamToleranceEi(
                          isMale: mThreadModel.isMale,
                          ei_d: mThreadModel.ei_d,
                          ei_d1: mThreadModel.ei_d1,
                        ),
              ),

              ThreadMinMaxMeanItem(
                max: context.watch<MThreadInfoCubit>().minorMajorDiamMaxSub(
                      diamS: mThreadModel.diam,
                      isMale: mThreadModel.isMale,
                      pitch: mThreadModel.pitch,
                      es_d: mThreadModel.es_d,
                      es_d1: mThreadModel.es_d1,
                    ),
                mean: context.watch<MThreadInfoCubit>().minorMajorDiamMeanSub(
                      diamS: mThreadModel.diam,
                      isMale: mThreadModel.isMale,
                      pitch: mThreadModel.pitch,
                      es_d: mThreadModel.es_d,
                      es_d1: mThreadModel.es_d1,
                      ei_d: mThreadModel.ei_d,
                      ei_d1: mThreadModel.ei_d1,
                    ),
                min: context.watch<MThreadInfoCubit>().minorMajorDiamMinSub(
                      diamS: mThreadModel.diam,
                      isMale: mThreadModel.isMale,
                      pitch: mThreadModel.pitch,
                      ei_d: mThreadModel.ei_d,
                      ei_d1: mThreadModel.ei_d1,
                    ),
              ),

              const SizedBox(
                height: 60,
              ),
            ],
          ),
        ),
      );
}

class _FemaleImage extends StatelessWidget {
  const _FemaleImage({
    required this.mThreadModel,
  });

  final MThreadModel mThreadModel;

  @override
  Widget build(BuildContext context) => MThreadInfoFemaleImage(
        path: ConstAssets.imageMThreadNuts,
        depth: context.watch<MThreadInfoCubit>().depth(
              isMale: mThreadModel.isMale,
              diam: mThreadModel.diam,
              pitch: mThreadModel.pitch,
            ),
        diamMajor: context.watch<MThreadInfoCubit>().minorMajorDiamSub(
              isMale: mThreadModel.isMale,
              diameter: mThreadModel.diam,
              pitch: mThreadModel.pitch,
            ),
        diamMiddle: context.watch<MThreadInfoCubit>().middleDiam(
              diam: mThreadModel.diam,
              pitch: mThreadModel.pitch,
            ),
        diamMinor: context.watch<MThreadInfoCubit>().minorMajorDiam(
              isMale: mThreadModel.isMale,
              diameter: mThreadModel.diam,
              pitch: mThreadModel.pitch,
            ),
        pitch: context.watch<MThreadInfoCubit>().pitch(mThreadModel.pitch),
        diamMajorToleranceBottom:
            context.watch<MThreadInfoCubit>().minorMajorDiamToleranceEi(
                  isMale: mThreadModel.isMale,
                  ei_d: mThreadModel.ei_d,
                  ei_d1: mThreadModel.ei_d1,
                ),
        diamMajorToleranceTop:
            context.watch<MThreadInfoCubit>().minorMajorDiamToleranceEs(
                  isMale: mThreadModel.isMale,
                  es_d: mThreadModel.es_d,
                  es_d1: mThreadModel.es_d1,
                ),
        diamMiddleToleranceBottom: context
            .watch<MThreadInfoCubit>()
            .middleDiamToleranceEi(ei_d2: mThreadModel.ei_d2),
        diamMiddleToleranceTop: context
            .watch<MThreadInfoCubit>()
            .middleDiamToleranceEs(es_d2: mThreadModel.es_d2),
        diamMinorToleranceBottom:
            context.watch<MThreadInfoCubit>().minorMajorDiamToleranceEi(
                  isMale: mThreadModel.isMale,
                  ei_d: mThreadModel.ei_d,
                  ei_d1: mThreadModel.ei_d1,
                ),
        diamMinorToleranceTop:
            context.watch<MThreadInfoCubit>().minorMajorDiamToleranceEs(
                  isMale: mThreadModel.isMale,
                  es_d: mThreadModel.es_d,
                  es_d1: mThreadModel.es_d1,
                ),
      );
}

class _MaleImage extends StatelessWidget {
  const _MaleImage({
    required this.mThreadModel,
  });

  final MThreadModel mThreadModel;

  @override
  Widget build(BuildContext context) => MThreadInfoMaleImage(
        path: ConstAssets.imageMThreadBolt,
        depth: context.watch<MThreadInfoCubit>().depth(
              isMale: mThreadModel.isMale,
              diam: mThreadModel.diam,
              pitch: mThreadModel.pitch,
            ),
        diamMajor: context.watch<MThreadInfoCubit>().minorMajorDiamSub(
              isMale: mThreadModel.isMale,
              diameter: mThreadModel.diam,
              pitch: mThreadModel.pitch,
            ),
        diamMiddle: context.watch<MThreadInfoCubit>().middleDiam(
              diam: mThreadModel.diam,
              pitch: mThreadModel.pitch,
            ),
        diamMinor: context.watch<MThreadInfoCubit>().minorMajorDiam(
              isMale: mThreadModel.isMale,
              diameter: mThreadModel.diam,
              pitch: mThreadModel.pitch,
            ),
        pitch: context.watch<MThreadInfoCubit>().pitch(mThreadModel.pitch),
        diamMajorToleranceBottom:
            context.watch<MThreadInfoCubit>().minorMajorDiamToleranceEi(
                  isMale: mThreadModel.isMale,
                  ei_d: mThreadModel.ei_d,
                  ei_d1: mThreadModel.ei_d1,
                ),
        diamMajorToleranceTop:
            context.watch<MThreadInfoCubit>().minorMajorDiamToleranceEs(
                  isMale: mThreadModel.isMale,
                  es_d: mThreadModel.es_d,
                  es_d1: mThreadModel.es_d1,
                ),
        diamMiddleToleranceBottom: context
            .watch<MThreadInfoCubit>()
            .middleDiamToleranceEi(ei_d2: mThreadModel.ei_d2),
        diamMiddleToleranceTop: context
            .watch<MThreadInfoCubit>()
            .middleDiamToleranceEs(es_d2: mThreadModel.es_d2),
        diamMinorToleranceBottom:
            context.watch<MThreadInfoCubit>().minorMajorDiamToleranceEi(
                  isMale: mThreadModel.isMale,
                  ei_d: mThreadModel.ei_d,
                  ei_d1: mThreadModel.ei_d1,
                ),
        diamMinorToleranceTop:
            context.watch<MThreadInfoCubit>().minorMajorDiamToleranceEs(
                  isMale: mThreadModel.isMale,
                  es_d: mThreadModel.es_d,
                  es_d1: mThreadModel.es_d1,
                ),
      );
}

class ThreadMinMaxMeanItem extends StatelessWidget {
  const ThreadMinMaxMeanItem({
    required this.max,
    required this.mean,
    required this.min,
    super.key,
  });

  final String max;
  final String mean;
  final String min;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(8),
        height: 65,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _columnNameValue(Localization.of(context).min, min, context),
            _columnNameValue(Localization.of(context).mean, mean, context),
            _columnNameValue(Localization.of(context).max, max, context),
          ],
        ),
      );
}

Widget _columnNameValue(String name, String value, BuildContext context) =>
    Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
        ),
        Text(
          value,
        ),
      ],
    );

class BasicThreadParametersItem extends StatelessWidget {
  const BasicThreadParametersItem({
    required this.title,
    required this.value,
    super.key,
  });
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.only(left: 8, right: 8),
        height: 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
            ),
            Text(
              value,
            ),
          ],
        ),
      );
}

String _updateTolerance(String value) {
  if (AppUtilsParse.stringToDouble(value) == 0) {
    return '';
  }

  if (AppUtilsParse.stringToDouble(value) > 0) {
    return '+$value';
  }

  return value;
}

class ThreadTolerancesItem extends StatelessWidget {
  const ThreadTolerancesItem({
    required this.title,
    required this.value,
    super.key,
    this.top = '',
    this.bottom = '',
  });
  final String title;
  final String value;
  final String top;
  final String bottom;

  @override
  Widget build(BuildContext context) {
    // not to show 0 and adding +, if more zero
    final updateTop = _updateTolerance(top);
    final updateBottom = _updateTolerance(bottom);

    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
          ),
          Row(
            children: [
              Text(
                value,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    updateTop,
                  ),
                  Text(
                    updateBottom,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ThreadCaptionItem extends StatelessWidget {
  const ThreadCaptionItem({
    required this.text,
    super.key,
  });
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          text,
          textAlign: TextAlign.center,
        ),
      );
}

class ThreadSubInfo extends StatelessWidget {
  const ThreadSubInfo({
    required this.model,
    super.key,
  });
  final MThreadModel model;
  @override
  Widget build(BuildContext context) {
    final title = model.isMale
        ? Localization.of(context).m_thread_male_description
        : Localization.of(context).m_thread_female_description;
    return Column(
      children: [
        Text(
          title,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            '( ${_getDeignationPitch(model, context)} )',
          ),
        ),
      ],
    );
  }
}

String _getDeignationPitch(MThreadModel mThreadModel, BuildContext context) {
  var typePitch = '';

  if (mThreadModel.isCoarsePitch) {
    typePitch = Localization.of(context).thread_pitch_coarse;
  } else if (mThreadModel.isFinePitch) {
    typePitch = Localization.of(context).thread_pitch_fine;
  } else if (mThreadModel.isSuperFinePitch) {
    typePitch = Localization.of(context).thread_pitch_superfine;
  }

  return typePitch;
}

class ThreadDeignationWidget extends StatelessWidget {
  const ThreadDeignationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mThreadModel = context.read<MThreadCubit>().state;

    final abrv = Localization.of(context).m_thread_abrv;
    final diam = mThreadModel.diam;
    final pitch = mThreadModel.pitch;
    final tolerance = mThreadModel.tolerance;

    return Text(
      '$abrv$diam x $pitch - $tolerance',
      textAlign: TextAlign.center,
    );
  }
}

class UnitsSegmentControl extends StatelessWidget {
  const UnitsSegmentControl({super.key});
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MThreadInfoCubit>();

    return BlocBuilder<MThreadInfoCubit, int>(
      builder: (context, state) => Container(
        margin: const EdgeInsets.all(8),
        child: CupertinoSegmentedControl<int>(
          unselectedColor: Theme.of(context).scaffoldBackgroundColor,
          borderColor: ConstColor.neutral_grey_400,
          children: {
            ConstCommon.mmUnit: buildSegment('mm'),
            ConstCommon.inchUnit: buildSegment('inch'),
          },
          groupValue: state,
          onValueChanged: bloc.setUnit,
        ),
      ),
    );
  }

  Widget buildSegment(String text) => Text(
        text,
      );
}
