import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moviz/screens/movie/detail/view/view.dart';
import 'package:moviz/screens/movie/listing/view/view.dart';
import 'package:moviz/screens/tv/detail/view/view.dart';
import 'package:moviz/screens/tv/listing/view/view.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _movieNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'movie');
final GlobalKey<NavigatorState> _tvNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'tv');

final GoRouter goRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/movie',
  debugLogDiagnostics: true,
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      builder: (BuildContext context, GoRouterState state,
          StatefulNavigationShell navigationShell) {
        // Return the widget that implements the custom shell (in this case
        // using a BottomNavigationBar). The StatefulNavigationShell is passed
        // to be able access the state of the shell and to navigate to other
        // branches in a stateful way.
        return ScaffoldWithNavBar(navigationShell: navigationShell);
      },
      branches: <StatefulShellBranch>[
        // The route branch for the first tab of the bottom navigation bar.
        StatefulShellBranch(
          navigatorKey: _movieNavigatorKey,
          routes: <RouteBase>[
            GoRoute(
              // The screen to display as the root in the first tab of the
              // bottom navigation bar.
              path: '/movie',
              builder: (BuildContext context, GoRouterState state) =>
                  const MoviePage(),
              routes: <RouteBase>[
                GoRoute(
                  path: 'movieDetails',
                  name: '/movieDetails',
                  builder: (BuildContext context, GoRouterState state) =>
                      const MovieDetailPage(),
                ),
              ],
            ),
          ],
        ),

        // The route branch for the second tab of the bottom navigation bar.
        StatefulShellBranch(
          // It's not necessary to provide a navigatorKey if it isn't also
          // needed elsewhere. If not provided, a default key will be used.
          navigatorKey: _tvNavigatorKey,
          routes: <RouteBase>[
            GoRoute(
              // The screen to display as the root in the second tab of the
              // bottom navigation bar.
              path: '/tv',
              builder: (BuildContext context, GoRouterState state) =>
                  const TvPage(),
              routes: <RouteBase>[
                GoRoute(
                  path: 'tvDetails',
                  name: '/tvDetails',
                  builder: (BuildContext context, GoRouterState state) =>
                      const TvDetailPage(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);

/// Builds the "shell" for the app by building a Scaffold with a
/// BottomNavigationBar, where [child] is placed in the body of the Scaffold.
class ScaffoldWithNavBar extends StatelessWidget {
  /// Constructs an [ScaffoldWithNavBar].
  const ScaffoldWithNavBar({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        // Here, the items of BottomNavigationBar are hard coded. In a real
        // world scenario, the items would most likely be generated from the
        // branches of the shell route, which can be fetched using
        // `navigationShell.route.branches`.
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Section A'),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Section B'),
        ],
        currentIndex: navigationShell.currentIndex,
        onTap: (int index) => _onTap(context, index),
      ),
    );
  }

  /// Navigate to the current location of the branch at the provided index when
  /// tapping an item in the BottomNavigationBar.
  void _onTap(BuildContext context, int index) {
    // When navigating to a new branch, it's recommended to use the goBranch
    // method, as doing so makes sure the last navigation state of the
    // Navigator for the branch is restored.
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
