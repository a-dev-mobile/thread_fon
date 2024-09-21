// Package imports:

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:threadfon/config/styles/app_text_style.dart';
import 'package:threadfon/core/widgets/my_error_widget.dart';
import 'package:threadfon/core/widgets/my_load_widget.dart';
import 'package:threadfon/core/widgets/my_msg_widget.dart';
import 'package:threadfon/data/m_thread/m_thread_repository.dart';
import 'package:threadfon/data/m_thread/models/diam/m_thread_diam_model.dart';
import 'package:threadfon/modules/threads/view/m_thread/cubit/m_thread_cubit.dart';
import 'package:threadfon/modules/threads/view/m_thread/view/m_thread_pitch/view/m_thread_pitch_page.dart';
import 'package:threadfon/src/common/localization/localization.dart';

class MThreadDiamPage extends StatelessWidget {
  const MThreadDiamPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = RepositoryProvider.of<MThreadRepository>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(Localization.of(context).thread_diam),
      ),
      body: FutureBuilder(
        future: repository.fetchMDiams(),
        builder: (context, AsyncSnapshot<List<MThreadDiamModel>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const MyLoadWidget();
            default:
              return snapshot.hasError
                  ? MyErrorWidget(errorMsg: snapshot.error.toString())
                  : snapshot.data == null
                      ? const MyMsgWidget(msg: 'no data')
                      : ThreadDiamCard(
                          listString: snapshot.data!.map((e) => e.diam).toList(),
                        );
          }
        },
      ),
    );
  }
}

class ThreadDiamCard extends StatelessWidget {
  const ThreadDiamCard({required this.listString, super.key});

  final List<String> listString;

  @override
  Widget build(BuildContext context) {
    final abrv = Localization.of(context).m_thread_abrv;
    return GridView.count(
      padding: EdgeInsets.only(bottom: 120.h),
      // shrinkWrap: true,
      crossAxisCount: 4,
      children: [
        for (final item in listString)
          InkWell(
            onTap: () {
              context.read<MThreadCubit>().setDiam(item);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const MThreadPitchPage(),
                ),
              );
            },
            child: Center(
              child: Text(
                '$abrv $item',
                style: AppTextStyle.H2(),
              ),
            ),
          ),
      ],
    );
  }
}
