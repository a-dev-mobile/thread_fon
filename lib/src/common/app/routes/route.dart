//
// import 'package:threadfon/modules/root/root_page.dart';
// import 'package:threadfon/modules/setting/setting_page.dart';
// import 'package:threadfon/modules/threads/view/m_thread/view/m_thread_diam/view/m_thread_diam_page.dart';
// import 'package:threadfon/modules/threads/view/m_thread/view/m_thread_info/view/m_thread_info_page.dart';
// import 'package:threadfon/modules/threads/view/m_thread/view/m_thread_male_female/view/m_thread_male_female_page.dart';
// import 'package:threadfon/modules/threads/view/m_thread/view/m_thread_pitch/view/m_thread_pitch_page.dart';
// import 'package:threadfon/modules/threads/view/m_thread/view/m_thread_tolerance/view/m_thread_tolerance_page.dart';

// @AutoRouterConfig(
//   replaceInRouteName: 'Page,Route',
// )
// class AppRouter extends RootStackRouter {
//   @override
//   List<AutoRoute> get routes => [
//         AutoRoute(
//           path: '/',
//           page: RootPage,
//           children: [
//             AutoRoute(
//               path: 'threads',
//               name: 'ThreadsRouter',
//               page: ThreadsWrapperPage,
//               children: [
//                 AutoRoute(path: '', page: MThreadMaleFemalePage),
//                 CustomRoute(
//                   path: 'm_thread_diam',
//                   page: MThreadDiamPage,
//                   transitionsBuilder: TransitionsBuilders.slideLeft,
//                 ),
//                 CustomRoute(
//                   path: 'm_thread_pitch',
//                   page: MThreadPitchPage,
//                   transitionsBuilder: TransitionsBuilders.slideLeft,
//                 ),
//                 CustomRoute(
//                   path: 'm_thread_tolerance',
//                   page: MThreadTolerancePage,
//                   transitionsBuilder: TransitionsBuilders.slideLeft,
//                 ),
//                 CustomRoute(
//                   path: 'm_thread_info',
//                   page: MThreadInfoPage,
//                   transitionsBuilder: TransitionsBuilders.slideLeft,
//                 ),
//                 RedirectRoute(path: '*', redirectTo: ''),
//               ],
//             ),
//             AutoRoute(
//               path: 'setting',
//               page: SettingPage,

//             ),
//           ],
//         ),
//       ];
// }
