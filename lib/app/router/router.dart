
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:threadfon/core/widgets/overlay_widget.dart';
import 'package:threadfon/features/splash/splash_screen.dart';
import 'package:threadfon/features/thread_type_selection/views/thread_type_selection_screen.dart';

// ignore: prefer-static-class
final _pageNavigatorKey = GlobalKey<NavigatorState>();
// ignore: prefer-static-class
final _tabNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  AppRouter() {
    router = _createRouter();
  }
  late final GoRouter router;

  GoRouter _createRouter() {
    return GoRouter(
        errorPageBuilder: (context, state) => MaterialPage<void>(
              key: state.pageKey,
              child: Center(child: Text(state.error.toString())),
            ),
        initialLocation: SplashScreen.path,
        // observers: <NavigatorObserver>[
        // CustomRouterObserver(screenTrackerNotifier),
        // ],
        debugLogDiagnostics: true,
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
                path: ThreadTypeSelectionScreen.path,
                name: ThreadTypeSelectionScreen.name,
                pageBuilder: (context, state) => NoTransitionPage(
                    child: const ThreadTypeSelectionScreen(),
                    key: state.pageKey),
              ),
            ],
            navigatorKey: _pageNavigatorKey,
          )
        ]);
  }
}
