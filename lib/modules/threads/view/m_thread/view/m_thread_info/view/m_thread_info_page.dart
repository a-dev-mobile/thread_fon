import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../config/styles/app_text_style.dart';
import '../../../../../../../core/constants/colors.dart';
import '../../../../../../../core/constants/common.dart';
import '../../../../../../../core/utils/app_utils.dart';
import '../../../../../../../core/widgets/my_divider.dart';
import '../../../cubit/m_thread_cubit.dart';
import '../../../models/models.dart';
import '../cubit/m_thread_info_cubit.dart';
import 'widgets/female/m_thread_info_female_image.dart';
import 'widgets/male/m_thread_info_male_image.dart';

class MThreadInfoPage extends StatelessWidget {
  const  MThreadInfoPage({Key? key}) : super(key: key);

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
    Key? key,
    required this.mThreadModel,
  }) : super(key: key);

  final MThreadModel mThreadModel;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).threads_info),
          // actions: [
          //   IconButton(onPressed: () {}, icon: const Icon(Icons.info_outline))
          // ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 120.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const UnitsSegmentControl(),
              //обозначение резьбы
              ThreadCaptionItem(
                text: AppLocalizations.of(context).thread_designation,
              ),
              // М35 х1
              const ThreadDeignationWidget(),
              //метрическая / мелкий шаг
              ThreadSubInfo(model: mThreadModel),
              const MyDivider(),
              BasicThreadParametersItem(
                title: AppLocalizations.of(context).thread_diam_nom,
                value:
                    context.watch<MThreadInfoCubit>().diam(mThreadModel.diam),
              ),
              BasicThreadParametersItem(
                title: AppLocalizations.of(context).thread_pitch,
                value:
                    context.watch<MThreadInfoCubit>().pitch(mThreadModel.pitch),
              ),
              // глубина резьбы
              BasicThreadParametersItem(
                title: AppLocalizations.of(context).thread_depth,
                value: context.watch<MThreadInfoCubit>().depth(
                      isMale: mThreadModel.isMale,
                      diam: mThreadModel.diam,
                      pitch: mThreadModel.pitch,
                    ),
              ),
              BasicThreadParametersItem(
                title: AppLocalizations.of(context).thread_class_tolerance,
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
                    ? AppLocalizations.of(context).diam_major
                    : AppLocalizations.of(context).diam_minor,
              ),
              // допуск наружний
              ThreadTolerancesItem(
                title: AppLocalizations.of(context).thread_tolerance,
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
                text: AppLocalizations.of(context).diam_middle,
              ),

              ThreadTolerancesItem(
                title: AppLocalizations.of(context).diam_middle,
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
                    ? AppLocalizations.of(context).diam_minor
                    : AppLocalizations.of(context).diam_major,
              ),

              ThreadTolerancesItem(
                title: AppLocalizations.of(context).thread_tolerance,
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

              SizedBox(
                height: 60.h,
              ),
            ],
          ),
        ),
      );
}

class _FemaleImage extends StatelessWidget {
  const _FemaleImage({
    Key? key,
    required this.mThreadModel,
  }) : super(key: key);

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
    Key? key,
    required this.mThreadModel,
  }) : super(key: key);

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
    Key? key,
    required this.max,
    required this.mean,
    required this.min,
  }) : super(key: key);

  final String max;
  final String mean;
  final String min;

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.all(8.w),
        height: 65.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _columnNameValue(AppLocalizations.of(context).min, min, context),
            _columnNameValue(AppLocalizations.of(context).mean, mean, context),
            _columnNameValue(AppLocalizations.of(context).max, max, context),
          ],
        ),
      );
}

Widget _columnNameValue(String name, String value, BuildContext context) =>
    Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name, style: AppTextStyle.LABEL_REGULAR()),
        Text(value, style: AppTextStyle.H3_REGULAR(context: context)),
      ],
    );

class BasicThreadParametersItem extends StatelessWidget {
  const BasicThreadParametersItem(
      {Key? key, required this.title, required this.value})
      : super(key: key);
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.only(left: 8.w, right: 8.w),
        height: 30.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: AppTextStyle.BODY_REGULAR()),
            Text(value, style: AppTextStyle.H2(context: context)),
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
    Key? key,
    required this.title,
    required this.value,
    this.top = '',
    this.bottom = '',
  }) : super(key: key);
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
      padding: EdgeInsets.only(left: 8.w, right: 8.w),
      height: 60.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyle.BODY_REGULAR()),
          Row(
            children: [
              Text(value, style: AppTextStyle.H2()),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    updateTop,
                    style: AppTextStyle.H3_REGULAR(context: context),
                  ),
                  Text(
                    updateBottom,
                    style: AppTextStyle.H3_REGULAR(context: context),
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
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.all(8.w),
        child: Text(
          text,
          style: AppTextStyle.H2(),
          textAlign: TextAlign.center,
        ),
      );
}

class ThreadSubInfo extends StatelessWidget {
  const ThreadSubInfo({
    Key? key,
    required this.model,
  }) : super(key: key);
  final MThreadModel model;
  @override
  Widget build(BuildContext context) {
    final title = model.isMale
        ? AppLocalizations.of(context).m_thread_male_description
        : AppLocalizations.of(context).m_thread_female_description;
    return Column(
      children: [
        Text(
          title,
          style: AppTextStyle.LABEL_REGULAR(),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: Text(
            '( ${_getDeignationPitch(model, context)} )',
            style: AppTextStyle.LABEL_REGULAR(),
          ),
        ),
      ],
    );
  }
}

String _getDeignationPitch(MThreadModel mThreadModel, BuildContext context) {
  var typePitch = '';

  if (mThreadModel.isCoarsePitch) {
    typePitch = AppLocalizations.of(context).thread_pitch_coarse;
  } else if (mThreadModel.isFinePitch) {
    typePitch = AppLocalizations.of(context).thread_pitch_fine;
  } else if (mThreadModel.isSuperFinePitch) {
    typePitch = AppLocalizations.of(context).thread_pitch_superfine;
  }

  return typePitch;
}

class ThreadDeignationWidget extends StatelessWidget {
  const ThreadDeignationWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mThreadModel = context.read<MThreadCubit>().state;

    final abrv = AppLocalizations.of(context).m_thread_abrv;
    final diam = mThreadModel.diam;
    final pitch = mThreadModel.pitch;
    final tolerance = mThreadModel.tolerance;

    return Text(
      '$abrv$diam x $pitch - $tolerance',
      style: AppTextStyle.H3_BOLD(),
      textAlign: TextAlign.center,
    );
  }
}

class UnitsSegmentControl extends StatelessWidget {
  const UnitsSegmentControl({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MThreadInfoCubit>();

    return BlocBuilder<MThreadInfoCubit, int>(
      builder: (context, state) => Container(
        margin: EdgeInsets.all(8.h),
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
        style: AppTextStyle.CAPTION(),
      );
}
