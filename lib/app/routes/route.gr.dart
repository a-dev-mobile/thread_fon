// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i9;
import 'package:flutter/material.dart' as _i10;

import '../../modules/root/root_page.dart' as _i1;
import '../../modules/setting/setting_page.dart' as _i3;
import '../../modules/threads/threads_wrapper_page.dart' as _i2;
import '../../modules/threads/view/m_thread/view/m_thread_diam/view/m_thread_diam_page.dart'
    as _i5;
import '../../modules/threads/view/m_thread/view/m_thread_info/view/m_thread_info_page.dart'
    as _i8;
import '../../modules/threads/view/m_thread/view/m_thread_male_female/view/m_thread_male_female_page.dart'
    as _i4;
import '../../modules/threads/view/m_thread/view/m_thread_pitch/view/m_thread_pitch_page.dart'
    as _i6;
import '../../modules/threads/view/m_thread/view/m_thread_tolerance/view/m_thread_tolerance_page.dart'
    as _i7;

class AppRouter extends _i9.RootStackRouter {
  AppRouter([_i10.GlobalKey<_i10.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    RootRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.RootPage());
    },
    ThreadsRouter.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.ThreadsWrapperPage());
    },
    SettingRouter.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.SettingPage());
    },
    MThreadMaleFemaleRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.MThreadMaleFemalePage());
    },
    MThreadDiamRoute.name: (routeData) {
      return _i9.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i5.MThreadDiamPage(),
          transitionsBuilder: _i9.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    MThreadPitchRoute.name: (routeData) {
      return _i9.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i6.MThreadPitchPage(),
          transitionsBuilder: _i9.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    MThreadToleranceRoute.name: (routeData) {
      return _i9.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i7.MThreadTolerancePage(),
          transitionsBuilder: _i9.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    MThreadInfoRoute.name: (routeData) {
      return _i9.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i8.MThreadInfoPage(),
          transitionsBuilder: _i9.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<_i9.RouteConfig> get routes => [
        _i9.RouteConfig(RootRoute.name, path: '/', children: [
          _i9.RouteConfig(ThreadsRouter.name,
              path: 'threads',
              parent: RootRoute.name,
              children: [
                _i9.RouteConfig(MThreadMaleFemaleRoute.name,
                    path: '', parent: ThreadsRouter.name),
                _i9.RouteConfig(MThreadDiamRoute.name,
                    path: 'm_thread_diam', parent: ThreadsRouter.name),
                _i9.RouteConfig(MThreadPitchRoute.name,
                    path: 'm_thread_pitch', parent: ThreadsRouter.name),
                _i9.RouteConfig(MThreadToleranceRoute.name,
                    path: 'm_thread_tolerance', parent: ThreadsRouter.name),
                _i9.RouteConfig(MThreadInfoRoute.name,
                    path: 'm_thread_info', parent: ThreadsRouter.name),
                _i9.RouteConfig('*#redirect',
                    path: '*',
                    parent: ThreadsRouter.name,
                    redirectTo: '',
                    fullMatch: true)
              ]),
          _i9.RouteConfig(SettingRouter.name,
              path: 'setting', parent: RootRoute.name)
        ])
      ];
}

/// generated route for
/// [_i1.RootPage]
class RootRoute extends _i9.PageRouteInfo<void> {
  const RootRoute({List<_i9.PageRouteInfo>? children})
      : super(RootRoute.name, path: '/', initialChildren: children);

  static const String name = 'RootRoute';
}

/// generated route for
/// [_i2.ThreadsWrapperPage]
class ThreadsRouter extends _i9.PageRouteInfo<void> {
  const ThreadsRouter({List<_i9.PageRouteInfo>? children})
      : super(ThreadsRouter.name, path: 'threads', initialChildren: children);

  static const String name = 'ThreadsRouter';
}

/// generated route for
/// [_i3.SettingPage]
class SettingRouter extends _i9.PageRouteInfo<void> {
  const SettingRouter() : super(SettingRouter.name, path: 'setting');

  static const String name = 'SettingRouter';
}

/// generated route for
/// [_i4.MThreadMaleFemalePage]
class MThreadMaleFemaleRoute extends _i9.PageRouteInfo<void> {
  const MThreadMaleFemaleRoute() : super(MThreadMaleFemaleRoute.name, path: '');

  static const String name = 'MThreadMaleFemaleRoute';
}

/// generated route for
/// [_i5.MThreadDiamPage]
class MThreadDiamRoute extends _i9.PageRouteInfo<void> {
  const MThreadDiamRoute()
      : super(MThreadDiamRoute.name, path: 'm_thread_diam');

  static const String name = 'MThreadDiamRoute';
}

/// generated route for
/// [_i6.MThreadPitchPage]
class MThreadPitchRoute extends _i9.PageRouteInfo<void> {
  const MThreadPitchRoute()
      : super(MThreadPitchRoute.name, path: 'm_thread_pitch');

  static const String name = 'MThreadPitchRoute';
}

/// generated route for
/// [_i7.MThreadTolerancePage]
class MThreadToleranceRoute extends _i9.PageRouteInfo<void> {
  const MThreadToleranceRoute()
      : super(MThreadToleranceRoute.name, path: 'm_thread_tolerance');

  static const String name = 'MThreadToleranceRoute';
}

/// generated route for
/// [_i8.MThreadInfoPage]
class MThreadInfoRoute extends _i9.PageRouteInfo<void> {
  const MThreadInfoRoute()
      : super(MThreadInfoRoute.name, path: 'm_thread_info');

  static const String name = 'MThreadInfoRoute';
}
