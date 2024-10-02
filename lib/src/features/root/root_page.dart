// // Package imports:
//
// import 'package:flutter/material.dart';
//
//
// import 'package:flutter_svg/svg.dart';

// import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

// import 'package:threadfon/app/admob/ad_helper.dart';

// import 'package:threadfon/core/constants/colors.dart';
// import 'package:threadfon/core/constants/common.dart';
// import 'package:threadfon/core/utils/app_log.dart';

// class RootPage extends StatefulWidget {
//   const RootPage({Key? key}) : super(key: key);

//   @override
//   State<RootPage> createState() => _RootPageState();
// }

// class _RootPageState extends State<RootPage> {

//   bool _isBottomBannerAdLoaded = false;

//   @override
//   void initState() {
//     super.initState();

//   }

//   @override
//   void dispose() {
//     super.dispose();

//   }

//   @override
//   Widget build(BuildContext context) {
//     final brightness = Theme.of(context).brightness;
//     final isDarkMode = brightness == Brightness.dark;
//     return AutoTabsScaffold(
//       // Removed the animation.
//       extendBody: true,
//       animationDuration: const Duration(),
//       // routes: const [ThreadsRouter(), SettingRouter()],

//       bottomNavigationBuilder: (context, tabsRouter) => Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           if (_isBottomBannerAdLoaded)
//             Container(
//               alignment: Alignment.center,

//             )
//           else
//             const SizedBox.shrink(),
//           Container(
//             decoration: BoxDecoration(
//               color: Theme.of(context).scaffoldBackgroundColor,
//               border: const Border(
//                 top: BorderSide(color: ConstColor.neutral_grey_400, width: 0.5),
//               ),
//             ),
//             child: SalomonBottomBar(
//               unselectedItemColor: Theme.of(context).primaryColor,
//               selectedItemColor: Theme.of(context).primaryColor,
//               currentIndex: tabsRouter.activeIndex,
//               onTap: (index) {
//                 if (index == 0) {
//                   //   AutoRouter.of(context).replaceAll([ThreadsRoute()]);

//                   tabsRouter.navigateNamed('/');
//                 }
//                 tabsRouter.setActiveIndex(index);
//               },
//               items: [
//                 SalomonBottomBarItem(
//                   unselectedColor: ConstColor.neutral_grey_400,
//                   icon: SvgPicture.asset(
//                     ConstAssets.svgMThread,
//                     width: 25.w,
//                     color: Theme.of(context).primaryColor,
//                     height: 25.w,
//                   ),
//                   title: Text(Localization.of(context).m_thread),
//                 ),
//                 SalomonBottomBarItem(
//                   icon: const Icon(Icons.settings),
//                   title: Text(Localization.of(context).setting),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
