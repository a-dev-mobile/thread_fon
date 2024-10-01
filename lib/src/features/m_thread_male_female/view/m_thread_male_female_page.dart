// Package imports:

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/src/provider.dart';
import 'package:threadfon/src/common/constant/enums.dart';
import 'package:threadfon/src/common/data/local_storage.dart';
import 'package:threadfon/src/common/data/local_storage_provider.dart';
import 'package:threadfon/src/common/styles/app_text_style.dart';
import 'package:threadfon/src/common/constant/common.dart';
import 'package:threadfon/src/features/threads/view/m_thread/cubit/m_thread_cubit.dart';
import 'package:threadfon/src/features/m_thread_diam/view/m_thread_diam_page.dart';
import 'package:threadfon/src/common/localization/localization.dart';

class MThreadMaleFemalePage extends StatelessWidget {
  const MThreadMaleFemalePage({super.key});

  @override
  Widget build(BuildContext context) {
    // final localStorage = LocalStorageProvider.of(context);
    final localStorage = LocalStorageProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Localization.of(context).thread_type,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ChoiceTypeThread(
              onTap: () {
                context.read<MThreadCubit>().setMale(false);
              localStorage.updateUserSelection(
                  (current) {
                    return current.copyWith(threadType: ThreadType.internal);
                  },
                );
                nextScreen(context);
              },
              pathSvg: ConstAssets.svgNuts,
              text: Localization.of(context).internal_thread,
            ),
          ),
          Expanded(
            child: ChoiceTypeThread(
              onTap: () {
                context.read<MThreadCubit>().setMale(true);
                      localStorage.updateUserSelection(
                  (current) {
                    return current.copyWith(threadType: ThreadType.external);
                  },
                );
                nextScreen(context);
              },
              pathSvg: ConstAssets.svgBolt,
              text: Localization.of(context).external_thread,
            ),
          ),
          const SizedBox(
            height: 180,
          ),
        ],
      ),
    );
  }

  void nextScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => const MThreadDiamPage(),
      ),
    );
  }
}

class ChoiceTypeThread extends StatelessWidget {
  const ChoiceTypeThread({
    required this.pathSvg,
    required this.text,
    required this.onTap,
    super.key,
  });

  final String pathSvg;
  final String text;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 3,
      margin: const EdgeInsets.all(8),
      color: scaffoldBackgroundColor,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SvgPicture.asset(
                  pathSvg,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                text.toUpperCase(),
                textAlign: TextAlign.center,
                style: AppTextStyle.LABEL_SEMI_BOLD(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
