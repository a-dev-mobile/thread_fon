// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'package:threadfon/app/admob/ad_helper.dart';
import 'package:threadfon/app/routes/route.gr.dart';
import 'package:threadfon/core/constants/colors.dart';
import 'package:threadfon/core/constants/common.dart';
import 'package:threadfon/core/utils/app_log.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  late BannerAd _bottomBannerAd;
  bool _isBottomBannerAdLoaded = false;

  void _createBottomBannerAd() {
    _bottomBannerAd = BannerAd(
      adUnitId: bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          log.w('Ad loaded.');
          setState(() {
            _isBottomBannerAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          log.e('Ad failed to load: $error');
        },

// Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) => log.w('Ad opened.'),
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) => log.w('Ad closed.'),
        // Called when an impression occurs on the ad.
        onAdImpression: (Ad ad) => log.w('Ad impression.'),
      ),
    );
    if (ConstCommon.isShowAd) _bottomBannerAd.load();
  }

  @override
  void initState() {
    super.initState();
    _createBottomBannerAd();
  }

  @override
  void dispose() {
    super.dispose();
    _bottomBannerAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDarkMode = brightness == Brightness.dark;
    return AutoTabsScaffold(
      // Removed the animation.
      extendBody: true,
      animationDuration: const Duration(),
      routes: const [ThreadsRouter(), SettingRouter()],

      bottomNavigationBuilder: (context, tabsRouter) => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (_isBottomBannerAdLoaded)
            Container(
              alignment: Alignment.center,
              height: _bottomBannerAd.size.height.toDouble(),
              width: _bottomBannerAd.size.width.toDouble(),
              child: AdWidget(ad: _bottomBannerAd),
            )
          else
            const SizedBox.shrink(),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              border: const Border(
                top: BorderSide(color: ConstColor.neutral_grey_400, width: 0.5),
              ),
            ),
            child: SalomonBottomBar(
              unselectedItemColor: Theme.of(context).primaryColor,
              selectedItemColor: Theme.of(context).primaryColor,
              currentIndex: tabsRouter.activeIndex,
              onTap: (index) {
                if (index == 0) {
                  //   AutoRouter.of(context).replaceAll([ThreadsRoute()]);

                  tabsRouter.navigateNamed('/');
                }
                tabsRouter.setActiveIndex(index);
              },
              items: [
                SalomonBottomBarItem(
                  unselectedColor: ConstColor.neutral_grey_400,
                  icon: SvgPicture.asset(
                    ConstAssets.svgMThread,
                    width: 25.w,
                    color: Theme.of(context).primaryColor,
                    height: 25.w,
                  ),
                  title: Text(AppLocalizations.of(context).m_thread),
                ),
                SalomonBottomBarItem(
                  icon: const Icon(Icons.settings),
                  title: Text(AppLocalizations.of(context).setting),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
