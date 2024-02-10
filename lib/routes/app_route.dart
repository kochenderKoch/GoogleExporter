import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_exporter/features/authentication/presentation/screens/authentication_screen.dart';
import 'package:google_exporter/features/download/presentation/screens/download_screen.dart';
import 'package:google_exporter/features/project/presentation/screens/project_overview.dart';
import 'package:google_exporter/features/settings/presentation/screens/settings_screen.dart';
import 'package:google_exporter/main/main_scaffold_adaptive.dart';
import 'package:talker_flutter/talker_flutter.dart';

// Global keys for different navigators to control navigation state
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _sectionNavigatorKey1 = GlobalKey<NavigatorState>();
final _sectionNavigatorKey2 = GlobalKey<NavigatorState>();
final _sectionNavigatorKey3 = GlobalKey<NavigatorState>();
final _sectionNavigatorKey4 = GlobalKey<NavigatorState>();
final _sectionNavigatorKey5 = GlobalKey<NavigatorState>();

/// GoRouter configuration with routes, redirects, and builders for different screens
final router = GoRouter(
  // Root navigator key that controls the main navigator of the app
  navigatorKey: _rootNavigatorKey,
  // Initial location based on the platform. For Android & iOS, it starts with '/text'
  initialLocation: (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) ? '/text' : '/',
  // Uncomment the below errorBuilder to provide a custom error screen
  //errorBuilder: (context, state) => ErrorScreen(state.error),
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      // Uncomment the below builder to provide a placeholder widget
      //builder: (context, state) => const Placeholder(),
      // Redirects from the root '/' to '/project'
      redirect: (context, state) => '/project',
    ),
    GoRoute(
      path: '/login',
      // Placeholder widget for the login screen, replace with actual login screen widget
      builder: (context, state) => const Placeholder(),
    ),
    GoRoute(
      // Path for the logs screen, which uses a custom TalkerScreen widget
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
      // Main scaffold of the app, containing the navigation shell
      builder: (context, state, navigationShell) {
        return MainScaffold(navigationShell);
      },
      branches: [
        
        StatefulShellBranch(
          // Navigator for the 'project' section
          navigatorKey: _sectionNavigatorKey2,
          routes: <RouteBase>[
            GoRoute(
              path: '/project',
              // Builder for the project overview screen
              builder: (context, state) => const ProjectOverviewScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          // Navigator for the 'project' section
          navigatorKey: _sectionNavigatorKey3,
          routes: <RouteBase>[
            GoRoute(
              path: '/authentications',
              // Builder for the project overview screen
              builder: (context, state) => const AuthenticationOverviewScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          // Navigator for the 'project' section
          navigatorKey: _sectionNavigatorKey4,
          routes: <RouteBase>[
            GoRoute(
              path: '/download',
              // Builder for the project overview screen
              builder: (context, state) => const DownloadOverviewScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          // Navigator for the 'settings' section
          navigatorKey: _sectionNavigatorKey5,
          routes: <RouteBase>[
            GoRoute(
              path: '/settings',
              // Builder for the settings screen, replace with actual settings widget
              builder: (context, state) => const SettingsScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);

/// Check whether the user is logged in and authorized to see the screen
/// Returns a string with the route to redirect if the user is not authenticated, otherwise returns null.
String? handleAuthentication(BuildContext context, GoRouterState state) {
  const isAuthenticated = false; // This should be replaced with actual authentication logic
  debugPrint('Handle: $isAuthenticated');
  if (!isAuthenticated) {
    return null; // Uncomment the next line to redirect unauthenticated users to the login screen
    //return '/login';
  }
}
