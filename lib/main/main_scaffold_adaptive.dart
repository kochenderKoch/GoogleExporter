import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_exporter/configs/breakpoints.dart';

/// [MainScaffold] is a widget that provides an adaptive scaffold structure
/// based on the screen size. It uses [AdaptiveScaffold] to adjust the layout.
///
/// This scaffold is used to manage the navigation and display of different
/// screens within the app.
class MainScaffold extends StatelessWidget {
  /// Constructor of [MainScaffold]
  const MainScaffold(this.navigationShell, {super.key});

  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      // An option to override the default breakpoints used for small, medium,
      // and large.
      leadingExtendedNavRail: const Center(
        child: Icon(Icons.earbuds_battery_sharp),
      ),
      // trailingNavRail: Expanded(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.end,
      //     children: [
      //       ElevatedButton(
      //         onPressed: () {
      //           //BetterFeedback.of(context).show((UserFeedback feedback) {});
      //         },
      //         child: const Text('Feedback'),
      //       ),
      //     ],
      //   ),
      // ),
      smallBreakpoint: const WidthPlatformBreakpoint(
        end: AdaptiveConfig.smallBreakpointEnd,
      ),
      mediumBreakpoint: const WidthPlatformBreakpoint(
        begin: AdaptiveConfig.mediumBreakpointStart,
        end: AdaptiveConfig.mediumBreakpointEnd,
      ),
      largeBreakpoint: const WidthPlatformBreakpoint(
        begin: AdaptiveConfig.largeBreakpointStart,
      ),
      useDrawer: false,
      selectedIndex: navigationShell.currentIndex,
      onSelectedIndexChange: (int index) {
        navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        );
      },
      destinations: <NavigationDestination>[
        NavigationDestination(
          icon: const Icon(Icons.home_outlined),
          selectedIcon: const Icon(Icons.home),
          label: AppLocalizations.of(context).home,
        ),
        NavigationDestination(
          icon: const Icon(Icons.download_outlined),
          selectedIcon: const Icon(Icons.download),
          label: AppLocalizations.of(context).appBarTitle,
        ),
        NavigationDestination(
          icon: const Icon(Icons.settings_outlined),
          selectedIcon: const Icon(Icons.settings),
          label: AppLocalizations.of(context).settings,
        ),
      ],
      bodyRatio: 0.6,

      body: (_) => navigationShell,
      smallBody: (_) => navigationShell,
      largeBody: (_) => navigationShell,

      // Define a default secondaryBody.
      largeSecondaryBody: navigationShell.currentIndex == 0
          ? (_) => Scaffold(
                floatingActionButton: FloatingActionButton(
                  onPressed: () {},
                  child: const Icon(Icons.add),
                ),
              )
          : AdaptiveScaffold.emptyBuilder,
      secondaryBody: AdaptiveScaffold.emptyBuilder,
      //TODO: Öffnen im Scaffold(Navigator to)
      smallSecondaryBody: AdaptiveScaffold.emptyBuilder,
    );
  }
}
