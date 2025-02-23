import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:threadfon/core/widgets/overlay_widget.dart';
import 'package:threadfon/features/01_splash/splash_screen.dart';
import 'package:threadfon/features/02_thread_type_selection/views/thread_type_selection_screen.dart';
import 'package:threadfon/features/03_metric_threads/diameter_selection/views/metric_diameter_screen.dart';
import 'package:threadfon/features/03_metric_threads/info/views/metric_full_screen_svg_view.dart';
import 'package:threadfon/features/03_metric_threads/info/views/metric_info_screen.dart';
import 'package:threadfon/features/03_metric_threads/pitch_selection/views/pitch_selection_screen.dart';
import 'package:threadfon/features/03_metric_threads/tolerance_selection/views/tolerance_selection_screen.dart';
import 'package:threadfon/features/04_imperial_threads/diameter_selection/views/imperial_diameter_screen.dart';
import 'package:threadfon/features/04_imperial_threads/info/views/imperial_info_screen.dart';
import 'package:threadfon/features/04_imperial_threads/tolerance_selection/views/imperial_tolerance_selection_screen.dart';
import 'package:threadfon/features/05_trapezoidal_threads/diameter_selection/views/trapezoidal_thread_screen.dart';
import 'package:threadfon/features/05_trapezoidal_threads/info/views/trapezoidal_info_screen.dart';
import 'package:threadfon/features/05_trapezoidal_threads/tolerance_selection/views/trapezoidal_tolerance_selection_screen.dart';
import 'package:threadfon/features/06_pipe_threads/diameter_selection/views/pipe_diameter_selection_screen.dart';
import 'package:threadfon/features/10_settings/views/about_app.dart';

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
      errorPageBuilder: (BuildContext context, GoRouterState state) =>
          MaterialPage<void>(
        key: state.pageKey,
        child: Center(child: Text(state.error.toString())),
      ),
      initialLocation: SplashScreen.path,
      debugLogDiagnostics: true,
      observers: <NavigatorObserver>[
        // Добавляем слушатель для логирования экранов
        _AnalyticsObserver(analytics: analytics),
      ],
      routes: <RouteBase>[
        ShellRoute(
          builder: (_, GoRouterState state, Widget child) {
            return OverlayScreen(goRouterState: state, child: child);
          },
          routes: <RouteBase>[
            GoRoute(
              path: SplashScreen.path,
              name: SplashScreen.name,
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  MaterialPage<void>(
                      child: const SplashScreen(), key: state.pageKey),
            ),
            GoRoute(
              path: MetricDiameterScreen.path,
              name: MetricDiameterScreen.name,
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  MaterialPage<void>(
                      child: const MetricDiameterScreen(), key: state.pageKey),
            ),
            GoRoute(
              path: ImperialDiameterScreen.path,
              name: ImperialDiameterScreen.name,
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  MaterialPage<void>(
                      child: const ImperialDiameterScreen(),
                      key: state.pageKey),
            ),
            GoRoute(
              path: ImperialToleranceSelectionScreen.path,
              name: ImperialToleranceSelectionScreen.name,
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  MaterialPage<void>(
                      child: const ImperialToleranceSelectionScreen(),
                      key: state.pageKey),
            ),
            GoRoute(
              path: ImperialInfoScreen.path,
              name: ImperialInfoScreen.name,
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  MaterialPage<void>(
                      child: const ImperialInfoScreen(), key: state.pageKey),
            ),
            GoRoute(
              path: ThreadTypeSelectionScreen.path,
              name: ThreadTypeSelectionScreen.name,
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  MaterialPage<void>(
                      child: const ThreadTypeSelectionScreen(),
                      key: state.pageKey),
            ),
            GoRoute(
              path: PitchSelectionScreen.path,
              name: PitchSelectionScreen.name,
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  MaterialPage<void>(
                      child: const PitchSelectionScreen(), key: state.pageKey),
            ),
            GoRoute(
              path: ToleranceSelectionScreen.path,
              name: ToleranceSelectionScreen.name,
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  MaterialPage<void>(
                      child: const ToleranceSelectionScreen(),
                      key: state.pageKey),
            ),
            GoRoute(
              path: MetricInfoScreen.path,
              name: MetricInfoScreen.name,
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  MaterialPage<void>(
                      child: const MetricInfoScreen(), key: state.pageKey),
            ),
            GoRoute(
                path: MetricFullScreenSvgView.path,
                name: MetricFullScreenSvgView.name,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  final Map<String, dynamic> data =
                      state.extra! as Map<String, dynamic>;

                  return MaterialPage<void>(
                      child: MetricFullScreenSvgView(
                        svgData: data['svgData'] as String,
                      ),
                      key: state.pageKey);
                }),
            GoRoute(
              path: TrapezoidalThreadScreen.path,
              name: TrapezoidalThreadScreen.name,
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  MaterialPage<void>(
                      child: const TrapezoidalThreadScreen(),
                      key: state.pageKey),
            ),
            GoRoute(
              path: TrapezoidalToleranceSelectionScreen.path,
              name: TrapezoidalToleranceSelectionScreen.name,
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  MaterialPage<void>(
                      child: const TrapezoidalToleranceSelectionScreen(),
                      key: state.pageKey),
            ),
            GoRoute(
              path: TrapezoidalInfoScreen.path,
              name: TrapezoidalInfoScreen.name,
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  MaterialPage<void>(
                      child: const TrapezoidalInfoScreen(), key: state.pageKey),
            ),
              GoRoute(
              path: PipeDiameterSelectionScreen.path,
              name: PipeDiameterSelectionScreen.name,
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  MaterialPage<void>(
                      child: const PipeDiameterSelectionScreen(), key: state.pageKey),
            ),
            GoRoute(
              path: AboutApp.path,
              name: AboutApp.name,
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  MaterialPage<void>(
                      child: const AboutApp(), key: state.pageKey),
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
      final String screenName =
          route.settings.name ?? route.settings.toString();
      analytics.logEvent(
        name: 'screen_view',
        parameters: <String, Object>{'screen_name': screenName},
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
