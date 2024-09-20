// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../app/routes/route.gr.dart';
import '../../../../../../../config/styles/app_text_style.dart';
import '../../../../../../../core/widgets/my_error_widget.dart';
import '../../../../../../../core/widgets/my_load_widget.dart';
import '../../../../../../../core/widgets/my_msg_widget.dart';
import '../../../../../../../data/m_thread/m_thread_repository.dart';
import '../../../../../../../data/m_thread/models/diam/m_thread_diam_model.dart';
import '../../../cubit/m_thread_cubit.dart';

class MThreadDiamPage extends StatelessWidget {
  const MThreadDiamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final repository = RepositoryProvider.of<MThreadRepository>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).thread_diam),
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
                          listString:
                              snapshot.data!.map((e) => e.diam).toList(),
                        );
          }
        },
      ),
    );
  }
}

class ThreadDiamCard extends StatelessWidget {
  const ThreadDiamCard({Key? key, required this.listString}) : super(key: key);

  final List<String> listString;

  @override
  Widget build(BuildContext context) {
    final abrv = AppLocalizations.of(context).m_thread_abrv;
    return GridView.count(
      padding: EdgeInsets.only(bottom: 120.h),
      // shrinkWrap: true,
      crossAxisCount: 4,
      children: [
        for (var item in listString)
          InkWell(
            onTap: () {
              context.read<MThreadCubit>().setDiam(item);
              AutoRouter.of(context).push(const MThreadPitchRoute());
            },
            child: Center(
              child: Text(
                '$abrv $item',
                style: AppTextStyle.H2(),
              ),
            ),
          )
      ],
    );
  }
}
