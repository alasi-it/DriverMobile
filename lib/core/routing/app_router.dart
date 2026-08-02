import 'package:flutter/material.dart';

import 'route_guard.dart';

class AppRouter {
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {}
  }

  Route<dynamic> guarded({
    required RouteSettings settings,
    required RouteGuard guard,
    required WidgetBuilder builder,
  }) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) {
        if (!guard.canActivate(settings)) {
          return guard.fallback(context: context);
        }
        return builder(context);
      },
    );
  }
}
