import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:threadfon/core/widgets/overlay_widget.dart';
import 'package:threadfon/features/imperial_threads/diameter_selection/views/imperial_diameter_screen.dart';
import 'package:threadfon/features/imperial_threads/info/views/imperial_info_screen.dart';
import 'package:threadfon/features/imperial_threads/tolerance_selection/views/imperial_tolerance_selection_screen.dart';
import 'package:threadfon/features/metric_threads/diameter_selection/views/metric_diameter_screen.dart';
import 'package:threadfon/features/metric_threads/info/views/full_screen_svg_view.dart';
import 'package:threadfon/features/metric_threads/info/views/info_screen.dart';
import 'package:threadfon/features/metric_threads/pitch_selection/views/pitch_selection_screen.dart';
import 'package:threadfon/features/settings/views/about_app.dart';
import 'package:threadfon/features/splash/splash_screen.dart';
import 'package:threadfon/features/thread_type_selection/views/thread_type_selection_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:threadfon/features/metric_threads/tolerance_selection/views/tolerance_selection_screen.dart';

class AppRouter {
  final FirebaseAnalytics analytics;
  final GlobalKey<NavigatorState> _pageNavigatorKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> _tabNavigatorKey =
      GlobalKey<NavigatorState>();

  AppRouter({required this.analytics}) {
    router = _createRouter();
  }
  late final GoRouter router;

  GoRouter _createRouter() {
    return GoRouter(
      navigatorKey: _pageNavigatorKey,
      errorPageBuilder: (context, state) => MaterialPage<void>(
        key: state.pageKey,
        child: Center(child: Text(state.error.toString())),
      ),
      initialLocation: SplashScreen.path,
      debugLogDiagnostics: true,
      observers: [
        // Добавляем слушатель для логирования экранов
        _AnalyticsObserver(analytics: analytics),
      ],
      routes: [
        ShellRoute(
          builder: (_, GoRouterState state, child) {
            return OverlayScreen(goRouterState: state, child: child);
          },
          routes: [
            GoRoute(
              path: SplashScreen.path,
              name: SplashScreen.name,
              pageBuilder: (context, state) => NoTransitionPage(
                  child: const SplashScreen(), key: state.pageKey),
            ),
            GoRoute(
              path: MetricDiameterScreen.path,
              name: MetricDiameterScreen.name,
              pageBuilder: (context, state) => NoTransitionPage(
                  child: const MetricDiameterScreen(), key: state.pageKey),
            ),
               GoRoute(
              path: ImperialDiameterScreen.path,
              name: ImperialDiameterScreen.name,
              pageBuilder: (context, state) =>
                  NoTransitionPage(child: const ImperialDiameterScreen(), key: state.pageKey),
            ),
                  GoRoute(
              path: ImperialToleranceSelectionScreen.path,
              name: ImperialToleranceSelectionScreen.name,
              pageBuilder: (context, state) =>
                  NoTransitionPage(child: const ImperialToleranceSelectionScreen(), key: state.pageKey),
            ),
                GoRoute(
              path: ImperialInfoScreen.path,
              name: ImperialInfoScreen.name,
              pageBuilder: (context, state) =>
                  NoTransitionPage(child: const ImperialInfoScreen(), key: state.pageKey),
            ),
            GoRoute(
              path: ThreadTypeSelectionScreen.path,
              name: ThreadTypeSelectionScreen.name,
              pageBuilder: (context, state) => NoTransitionPage(
                  child: const ThreadTypeSelectionScreen(), key: state.pageKey),
            ),
            GoRoute(
              path: PitchSelectionScreen.path,
              name: PitchSelectionScreen.name,
              pageBuilder: (context, state) => NoTransitionPage(
                  child: const PitchSelectionScreen(), key: state.pageKey),
            ),
            GoRoute(
              path: ToleranceSelectionScreen.path,
              name: ToleranceSelectionScreen.name,
              pageBuilder: (context, state) => NoTransitionPage(
                  child: const ToleranceSelectionScreen(), key: state.pageKey),
            ),
            GoRoute(
              path: InfoScreen.path,
              name: InfoScreen.name,
              pageBuilder: (context, state) => NoTransitionPage(
                  child: const InfoScreen(), key: state.pageKey),
            ),
            GoRoute(
                path: FullScreenSvgView.path,
                name: FullScreenSvgView.name,
                pageBuilder: (context, state) {
                  final data = state.extra! as Map<String, dynamic>;
                  return NoTransitionPage(
                      child: FullScreenSvgView(
                        svgData: data['svgData'] as String,
                      ),
                      key: state.pageKey);
                }),
            GoRoute(
              path: AboutApp.path,
              name: AboutApp.name,
              pageBuilder: (context, state) =>
                  NoTransitionPage(child: const AboutApp(), key: state.pageKey),
            ),
          ],
          navigatorKey: _tabNavigatorKey,
        ),
      ],
    );
  }
}

class _AnalyticsObserver extends NavigatorObserver {
  final FirebaseAnalytics analytics;

  _AnalyticsObserver({required this.analytics});

  void _sendScreenView(Route<dynamic>? route) {
    if (route is MaterialPageRoute) {
      final screenName = route.settings.name ?? route.settings.toString();
      analytics.logEvent(
        name: 'screen_view',
        parameters: {'screen_name': screenName},
      );
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _sendScreenView(route);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _sendScreenView(newRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute != null) {
      _sendScreenView(previousRoute);
    }
  }
}
