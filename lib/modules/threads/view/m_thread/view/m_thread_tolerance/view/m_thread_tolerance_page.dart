// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../../../../../app/admob/ad_helper.dart';
import '../../../../../../../app/routes/route.gr.dart';
import '../../../../../../../config/styles/app_text_style.dart';
import '../../../../../../../core/constants/common.dart';
import '../../../../../../../core/utils/app_log.dart';
import '../../../../../../../core/widgets/my_error_widget.dart';
import '../../../../../../../core/widgets/my_load_widget.dart';
import '../../../../../../../core/widgets/my_msg_widget.dart';
import '../../../../../../../data/m_thread/m_thread_repository.dart';
import '../../../../../../../data/m_thread/models/tolerance/m_thread_tolerance_model.dart';
import '../../../cubit/m_thread_cubit.dart';
import 'cubit/ads_interstitial_cubit.dart';

class MThreadTolerancePage extends StatelessWidget {
  const MThreadTolerancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => AdsInterstitialCubit(),
        child: _MThreadTolerancePage(),
      );
}

class _MThreadTolerancePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = context.read<MThreadCubit>().state;

    final repository = RepositoryProvider.of<MThreadRepository>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).thread_tolerance),
      ),
      body: FutureBuilder(
        future: repository.fetchMTolerance(
          diam: model.diam,
          isMale: model.isMale,
          pitch: model.pitch,
        ),
        builder: (context, AsyncSnapshot<MThreadToleranceModel> snapshot) {
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
    Key? key,
  }) : super(key: key);

  final List<String> listTolerance;

  @override
  State<ToleranceWidget> createState() => _ToleranceWidgetState();
}

class _ToleranceWidgetState extends State<ToleranceWidget> {
  int _interstitialLoadAttempts = 0;
  InterstitialAd? _interstitialAd;

  void _createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _interstitialLoadAttempts = 0;
          _interstitialAd!.setImmersiveMode(true);
        },
        onAdFailedToLoad: (LoadAdError error) {
          _interstitialLoadAttempts += 1;
          _interstitialAd = null;
          if (_interstitialLoadAttempts <= ConstCommon.maxFailedLoadAttempts) {
            _createInterstitialAd();
          }
        },
      ),
    );
  }

  void _showInterstialAd() {
    if (_interstitialAd == null) {
      log.w('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          log.w('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        log.w('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        log.w('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdImpression: (InterstitialAd ad) => log.i('$ad impression occurred.'),
    );

    _interstitialAd!.show();
    _interstitialAd = null;
  }

  void showAd() {
    log.w('start ad');
    _showInterstialAd();
  }

  @override
  void initState() {
    super.initState();
    _createInterstitialAd();
  }

  @override
  void dispose() {
    super.dispose();

    _interstitialAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AdsInterstitialCubit>().state;
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 120.h),
      child: Column(
        children: [
          for (var item in widget.listTolerance)
            ToleranceItem(
              tolerance: item,
              onTap: () {
                if (state > ConstCommon.maxViewInfoPageBeforeAds) {
                  context.read<AdsInterstitialCubit>().reset();
                  if (ConstCommon.isShowAd) showAd();
                  context.read<AdsInterstitialCubit>().increment();
                } else {
                  context.read<AdsInterstitialCubit>().increment();
                }
              },
            ),
        ],
      ),
    );
  }
}

class ToleranceItem extends StatelessWidget {
  const ToleranceItem({
    Key? key,
    required this.tolerance,
    required this.onTap,
  }) : super(key: key);
  final String tolerance;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    final repository = RepositoryProvider.of<MThreadRepository>(context);
    final mThreadModelCubit = context.read<MThreadCubit>();
    final abrv = AppLocalizations.of(context).m_thread_abrv;

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

        await AutoRouter.of(context).push(const MThreadInfoRoute());
        onTap();
      },
      title: Center(
        child: Text(
          '$abrv $diam x $pitch - $tolerance',
          style: AppTextStyle.H2(),
        ),
      ),
    );
  }
}
