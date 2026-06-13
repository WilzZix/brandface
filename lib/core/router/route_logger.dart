import 'package:flutter/material.dart';

/// NavigatorObserver that logs every route change to the console.
/// Lines are tagged `[NAV]` so they're easy to filter in `flutter logs`,
/// Xcode console, or IDE consoles.
class RouteLoggerObserver extends NavigatorObserver {
  void _log(String action, Route<dynamic>? route, Route<dynamic>? previous) {
    final newPath = _pathOf(route);
    final oldPath = _pathOf(previous);
    final line =
        '[NAV] $action  →  ${newPath ?? '(none)'}'
        '${oldPath != null ? '   (from $oldPath)' : ''}';
    debugPrint(line);
    // ignore: avoid_print
    print(line);
  }

  String? _pathOf(Route<dynamic>? route) {
    if (route == null) return null;
    final name = route.settings.name;
    if (name != null && name.isNotEmpty) return name;
    return route.runtimeType.toString();
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _log('PUSH', route, previousRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _log('POP ', route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    _log('REPL', newRoute, oldRoute);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _log('REMV', route, previousRoute);
  }
}
