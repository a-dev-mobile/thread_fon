import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:threadfon/core/services/logging/logger.dart';
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
import 'package:threadfon/features/06_pipe_threads/info/views/pipe_info_screen.dart';
import 'package:threadfon/features/10_settings/views/about_app.dart';

/// Класс маршрутизации приложения с поддержкой аналитики и вложенной навигации.
///
/// Управляет маршрутами приложения, предоставляет аналитику через Firebase и
/// использует GoRouter для эффективной навигации.
class AppRouter {
  final FirebaseAnalytics analytics;

  /// Глобальные ключи для управления навигацией
  final GlobalKey<NavigatorState> _pageNavigatorKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> _tabNavigatorKey =
      GlobalKey<NavigatorState>();

  /// Основной объект маршрутизатора
  late final GoRouter router;

  AppRouter({required this.analytics}) {
    router = _createRouter();
  }

  /// Создает и конфигурирует маршрутизатор GoRouter
  GoRouter _createRouter() {
    return GoRouter(
      navigatorKey: _pageNavigatorKey,
      initialLocation: SplashScreen.path,
      debugLogDiagnostics: true,
      observers: <NavigatorObserver>[_AnalyticsObserver(analytics: analytics)],
      errorPageBuilder: (BuildContext context, GoRouterState state) =>
          MaterialPage<void>(
        key: state.pageKey,
        child: Center(
          child: Text(
            'Ошибка навигации: ${state.error?.toString() ?? "Неизвестная ошибка"}',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
      ),
      routes: <RouteBase>[
        ShellRoute(
          builder: (BuildContext context, GoRouterState state, Widget child) {
            return OverlayScreen(goRouterState: state, child: child);
          },
          navigatorKey: _tabNavigatorKey,
          routes: <RouteBase>[
            // Основной экран
            _buildRoute(
              path: SplashScreen.path,
              name: SplashScreen.name,
              builder: (BuildContext context, GoRouterState state) =>
                  const SplashScreen(),
            ),

            // Экран выбора типа резьбы
            _buildRoute(
              path: ThreadTypeSelectionScreen.path,
              name: ThreadTypeSelectionScreen.name,
              builder: (BuildContext context, GoRouterState state) =>
                  const ThreadTypeSelectionScreen(),
            ),

            // Метрические экраны
            ..._buildGroup('Метрические экраны', <GoRoute>[
              _buildRoute(
                path: MetricDiameterScreen.path,
                name: MetricDiameterScreen.name,
                builder: (BuildContext context, GoRouterState state) =>
                    const MetricDiameterScreen(),
              ),
              _buildRoute(
                path: PitchSelectionScreen.path,
                name: PitchSelectionScreen.name,
                builder: (BuildContext context, GoRouterState state) =>
                    const PitchSelectionScreen(),
              ),
              _buildRoute(
                path: ToleranceSelectionScreen.path,
                name: ToleranceSelectionScreen.name,
                builder: (BuildContext context, GoRouterState state) =>
                    const ToleranceSelectionScreen(),
              ),
              _buildRoute(
                path: MetricInfoScreen.path,
                name: MetricInfoScreen.name,
                builder: (BuildContext context, GoRouterState state) =>
                    const MetricInfoScreen(),
              ),
              _buildRouteWithExtra(
                path: MetricFullScreenSvgView.path,
                name: MetricFullScreenSvgView.name,
                builder: (BuildContext context, GoRouterState state) {
                  final Map<String, dynamic> data =
                      state.extra! as Map<String, dynamic>;

                  return MetricFullScreenSvgView(
                      svgData: data['svgData'] as String);
                },
              ),
            ]),

            // Имперские экраны
            ..._buildGroup('Имперские экраны', <GoRoute>[
              _buildRoute(
                path: ImperialDiameterScreen.path,
                name: ImperialDiameterScreen.name,
                builder: (BuildContext context, GoRouterState state) =>
                    const ImperialDiameterScreen(),
              ),
              _buildRoute(
                path: ImperialToleranceSelectionScreen.path,
                name: ImperialToleranceSelectionScreen.name,
                builder: (BuildContext context, GoRouterState state) =>
                    const ImperialToleranceSelectionScreen(),
              ),
              _buildRoute(
                path: ImperialInfoScreen.path,
                name: ImperialInfoScreen.name,
                builder: (BuildContext context, GoRouterState state) =>
                    const ImperialInfoScreen(),
              ),
            ]),

            // Трапециевидные экраны
            ..._buildGroup('Трапециевидные экраны', <GoRoute>[
              _buildRoute(
                path: TrapezoidalThreadScreen.path,
                name: TrapezoidalThreadScreen.name,
                builder: (BuildContext context, GoRouterState state) =>
                    const TrapezoidalThreadScreen(),
              ),
              _buildRoute(
                path: TrapezoidalToleranceSelectionScreen.path,
                name: TrapezoidalToleranceSelectionScreen.name,
                builder: (BuildContext context, GoRouterState state) =>
                    const TrapezoidalToleranceSelectionScreen(),
              ),
              _buildRoute(
                path: TrapezoidalInfoScreen.path,
                name: TrapezoidalInfoScreen.name,
                builder: (BuildContext context, GoRouterState state) =>
                    const TrapezoidalInfoScreen(),
              ),
            ]),

            // Экраны трубной резьбы
            ..._buildGroup('Экраны трубной резьбы', <GoRoute>[
              _buildRoute(
                path: PipeDiameterSelectionScreen.path,
                name: PipeDiameterSelectionScreen.name,
                builder: (BuildContext context, GoRouterState state) =>
                    const PipeDiameterSelectionScreen(),
              ),
              _buildRoute(
                path: PipeInfoScreen.path,
                name: PipeInfoScreen.name,
                builder: (BuildContext context, GoRouterState state) =>
                    const PipeInfoScreen(),
              ),
            ]),

            // Дополнительные экраны
            ..._buildGroup('Дополнительные экраны', <GoRoute>[
              _buildRoute(
                path: AboutApp.path,
                name: AboutApp.name,
                builder: (BuildContext context, GoRouterState state) =>
                    const AboutApp(),
              ),
            ]),
          ],
        ),
      ],
    );
  }

  /// Вспомогательный метод для создания маршрута
  GoRoute _buildRoute({
    required String path,
    required String name,
    required Widget Function(BuildContext, GoRouterState) builder,
  }) {
    return GoRoute(
      path: path,
      name: name,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          MaterialPage<void>(
        key: state.pageKey,
        child: builder(context, state),
      ),
    );
  }

  /// Вспомогательный метод для создания маршрута с дополнительными данными
  GoRoute _buildRouteWithExtra({
    required String path,
    required String name,
    required Widget Function(BuildContext, GoRouterState) builder,
  }) {
    return GoRoute(
      path: path,
      name: name,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          MaterialPage<void>(
        key: state.pageKey,
        child: builder(context, state),
      ),
    );
  }

  /// Вспомогательный метод для группировки маршрутов (для читаемости)
  List<GoRoute> _buildGroup(String groupName, List<GoRoute> routes) {
    return routes;
  }
}

/// Наблюдатель для отслеживания навигации и отправки данных в аналитику
class _AnalyticsObserver extends NavigatorObserver {
  final FirebaseAnalytics analytics;
  static final LogService _logger =
      LogService('AnalyticsObserver'); // Убрано const

  _AnalyticsObserver({required this.analytics});

  /// Отправляет событие просмотра экрана в Firebase Analytics
  Future<void> _sendScreenView(Route<dynamic>? route) async {
    try {
      if (route is MaterialPageRoute) {
        final String screenName = route.settings.name ?? 'unknown_screen';
        await analytics.logEvent(
          name: 'screen_view',
          parameters: <String, Object>{'screen_name': screenName},
        );
        _logger.i('Отправлено событие аналитики для экрана: $screenName');
      }
    } catch (e) {
      _logger.e('Ошибка при отправке аналитики', error: e);
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
