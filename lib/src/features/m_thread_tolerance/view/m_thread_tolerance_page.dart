// Package imports:

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threadfon/src/common/data/m_thread_repository.dart';
import 'package:threadfon/src/common/localization/localization.dart';
import 'package:threadfon/src/common/widgets/my_error_widget.dart';
import 'package:threadfon/src/common/widgets/my_load_widget.dart';
import 'package:threadfon/src/common/widgets/my_msg_widget.dart';
import 'package:threadfon/src/features/m_thread_info/view/m_thread_info_page.dart';
import 'package:threadfon/src/features/threads/view/m_thread/cubit/m_thread_cubit.dart';

class MThreadTolerancePage extends StatelessWidget {
  const MThreadTolerancePage({super.key});

  @override
  Widget build(BuildContext context) => _MThreadTolerancePage();
}

class _MThreadTolerancePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = context.read<MThreadCubit>().state;

    final repository = RepositoryProvider.of<MThreadRepository>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(Localization.of(context).thread_tolerance),
      ),
      body: FutureBuilder(
        future: repository.fetchMTolerance(
          diam: model.diam,
          isMale: model.isMale,
          pitch: model.pitch,
        ),
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
                  context
                      .read<MThreadCubit>()
                      .setIdTolerance(snapshot.data!.id);

                  return ToleranceWidget(
                    listTolerance: (snapshot.data!).listTolerance,
                  );
                }
              }
          }
        },
      ),
    );
  }
}

class ToleranceWidget extends StatefulWidget {
  const ToleranceWidget({
    required this.listTolerance,
    super.key,
  });

  final List<String> listTolerance;

  @override
  State<ToleranceWidget> createState() => _ToleranceWidgetState();
}

class _ToleranceWidgetState extends State<ToleranceWidget> {
  final int _interstitialLoadAttempts = 0;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 120),
        child: Column(
          children: [
            for (final item in widget.listTolerance)
              ToleranceItem(tolerance: item, onTap: () {}),
          ],
        ),
      );
}

class ToleranceItem extends StatelessWidget {
  const ToleranceItem({
    required this.tolerance,
    required this.onTap,
    super.key,
  });
  final String tolerance;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    final repository = RepositoryProvider.of<MThreadRepository>(context);
    final mThreadModelCubit = context.read<MThreadCubit>();
    final abrv = Localization.of(context).m_thread_abrv;

    final diam = mThreadModelCubit.state.diam;
    final pitch = mThreadModelCubit.state.pitch;
    final id = mThreadModelCubit.state.id;
    final isMale = mThreadModelCubit.state.isMale;

    return ListTile(
      contentPadding: const EdgeInsets.all(8),
      onTap: () async {
        context.read<MThreadCubit>().setTolerance(tolerance);
        final toleranceValues = await repository.fetchMToleranceValues(
          id: id,
          tolerance: tolerance,
          isMale: isMale,
        );
// Write tolerance values
        mThreadModelCubit.setToleranceValue(
          ei_d: toleranceValues.ei_d,
          ei_d1: toleranceValues.ei_d1,
          ei_d2: toleranceValues.ei_d2,
          es_d: toleranceValues.es_d,
          es_d1: toleranceValues.es_d1,
          es_d2: toleranceValues.es_d2,
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MThreadInfoPage(),
          ),
        );
        // await AutoRouter.of(context).push(const MThreadInfoRoute());
      },
      title: Center(
        child: Text(
          '$abrv $diam x $pitch - $tolerance',
        ),
      ),
    );
  }
}
