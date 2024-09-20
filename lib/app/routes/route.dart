// Package imports:
import 'package:auto_route/auto_route.dart';

import '../../modules/root/root_page.dart';
import '../../modules/setting/setting_page.dart';
import '../../modules/threads/threads_wrapper_page.dart';
import '../../modules/threads/view/m_thread/view/m_thread_diam/view/m_thread_diam_page.dart';
import '../../modules/threads/view/m_thread/view/m_thread_info/view/m_thread_info_page.dart';
import '../../modules/threads/view/m_thread/view/m_thread_male_female/view/m_thread_male_female_page.dart';
import '../../modules/threads/view/m_thread/view/m_thread_pitch/view/m_thread_pitch_page.dart';
import '../../modules/threads/view/m_thread/view/m_thread_tolerance/view/m_thread_tolerance_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute<dynamic>(
      path: '/',
      page: RootPage,
      children: [
        AutoRoute<dynamic>(
          path: 'threads',
          name: 'ThreadsRouter',
          // page: EmptyRouterPage,
          page: ThreadsWrapperPage,
          children: [
            AutoRoute<dynamic>(path: '', page: MThreadMaleFemalePage),
//
            // CustomRoute<dynamic>(
            //     path: 'm_thread_male_female',
            //     page: MThreadMaleFemalePage,
            //     transitionsBuilder: TransitionsBuilders.slideLeft),
            CustomRoute<dynamic>(
              path: 'm_thread_diam',
              page: MThreadDiamPage,
              transitionsBuilder: TransitionsBuilders.slideLeft,
            ),
            CustomRoute<dynamic>(
              path: 'm_thread_pitch',
              page: MThreadPitchPage,
              transitionsBuilder: TransitionsBuilders.slideLeft,
            ),
            CustomRoute<dynamic>(
              path: 'm_thread_tolerance',
              page: MThreadTolerancePage,
              transitionsBuilder: TransitionsBuilders.slideLeft,
            ),
            CustomRoute<dynamic>(
              path: 'm_thread_info',
              page: MThreadInfoPage,
              transitionsBuilder: TransitionsBuilders.slideLeft,
            ),

            RedirectRoute(path: '*', redirectTo: ''),
          ],
        ),
        AutoRoute<dynamic>(
          path: 'setting',
          page: SettingPage,
          name: 'SettingRouter',
        ),
      ],
    ),
  ],
)
class $AppRouter {}
