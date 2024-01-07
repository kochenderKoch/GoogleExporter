import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_exporter/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:google_exporter/features/project/presentation/project_overview.dart';
import 'package:google_exporter/features/settings/presentation/screens/settings_screen.dart';
import 'package:google_exporter/main/main_scaffold.dart';
import 'package:talker_flutter/talker_flutter.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _sectionNavigatorKey1 = GlobalKey<NavigatorState>();
final _sectionNavigatorKey2 = GlobalKey<NavigatorState>();
final _sectionNavigatorKey3 = GlobalKey<NavigatorState>();

/// GoRouter configuration
final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation:
      (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) ? '/text' : '/',
  //errorBuilder: (context, state) => ErrorScreen(state.error),
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      //builder: (context, state) => const Placeholder(),
      redirect: (context, state) => '/home',
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const Placeholder(),
    ),
    GoRoute(
      redirect: handleAuthentication,
      path: '/dio/logs',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final talker = state.extra! as Talker;
        return TalkerScreen(
          talker: talker,
          theme: TalkerScreenTheme(
            backgroundColor: Theme.of(context).colorScheme.background,
            textColor: Theme.of(context).colorScheme.onBackground,
          ),
        );
      },
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainScaffold(navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _sectionNavigatorKey1,
          routes: <RouteBase>[
            GoRoute(
              redirect: handleAuthentication,
              path: '/home',
              builder: (context, state) => const DashboardScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _sectionNavigatorKey2,
          routes: <RouteBase>[
            GoRoute(
              redirect: handleAuthentication,
              path: '/project',
              builder: (context, state) => const ProjectOverviewScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _sectionNavigatorKey3,
          routes: <RouteBase>[
            GoRoute(
              redirect: handleAuthentication,
              path: '/settings',
              builder: (context, state) => const SettingsScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);

/// Check wether the User is logged in and authorized to see the screen
String? handleAuthentication(BuildContext context, GoRouterState state) {
  const isAuthenticated = false;
  debugPrint('Handle: $isAuthenticated');
  if (!isAuthenticated) {
    return null;
    //return '/login';
  }
}
