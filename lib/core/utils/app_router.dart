import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:konar_mobile/core/presentation/navigation_bar_icon.dart';
import 'package:konar_mobile/core/presentation/not_found_screen.dart';
import 'package:konar_mobile/features/guest_page.dart';
import 'package:konar_mobile/features/info_page/presentation/info_page.dart';
import 'package:konar_mobile/features/login_page/data/login_repository.dart';
import 'package:konar_mobile/features/login_page/presentation/login_screen.dart';
import 'package:konar_mobile/features/main_page/presentation/main_page.dart';
import 'package:konar_mobile/features/main_page/presentation/map_controller.dart';
import 'package:konar_mobile/features/map_page/presentation/map_page.dart';
import 'package:konar_mobile/features/profile_page/presentation/profile_page.dart';

import 'go_touter_refresh_stream.dart';

enum AppRoute { loginPage, mainPage, mapPage, infoPage, profilePage, guestPage }

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
final _shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'shellB');
final _shellNavigatorCKey = GlobalKey<NavigatorState>(debugLabel: 'shellC');
final _shellNavigatorDKey = GlobalKey<NavigatorState>(debugLabel: 'shellD');

final goRouterProvider = Provider.autoDispose<GoRouter>(
  (ref) {
    final authRepository = ref.watch(realAuthRepositoryProvider);
    return GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      navigatorKey: _rootNavigatorKey,
      redirect: (context, GoRouterState state) {
        final isLoggedIn = authRepository.currentUser != null;
        if (isLoggedIn) {
          if (state.uri.toString() == '/') {
            return '/mainPage';
          }
        } else {
          return '/';
        }
        return null;
      },
      refreshListenable:
          GoRouterRefreshStream(authRepository.authStateChanges()),
      routes: [
        GoRoute(
          path: '/',
          name: AppRoute.loginPage.name,
          builder: (context, state) => LoginScreen(),
          routes: const [],
        ),
        StatefulShellRoute.indexedStack(
            builder: (context, state, navigationShell) {
              return ScaffoldWithNestedNavigation(
                navigationShell: navigationShell,
              );
            },
            branches: [
              StatefulShellBranch(
                navigatorKey: _shellNavigatorAKey,
                routes: [
                  GoRoute(
                    path: '/mainPage',
                    pageBuilder: (context, state) => const NoTransitionPage(
                      child: MainPage(),
                    ),
                    routes: const [],
                  ),
                ],
              ),
              StatefulShellBranch(
                navigatorKey: _shellNavigatorBKey,
                routes: [
                  GoRoute(
                    path: '/mapPage',
                    name: AppRoute.mapPage.name,
                    pageBuilder: (context, state) => NoTransitionPage(
                      key: UniqueKey(),
                      child: MapPage(
                          // lat: state.uri.queryParameters['lat'] ?? '[]',
                          // long: state.uri.queryParameters['long'] ?? '[]',
                          // whatsView: state.uri.queryParameters['whatsView'] ?? '',
                          ),
                    ),
                    routes: [],
                  ),
                ],
              ),
              StatefulShellBranch(
                navigatorKey: _shellNavigatorCKey,
                routes: [
                  GoRoute(
                    path: '/infoPage',
                    name: AppRoute.infoPage.name,
                    pageBuilder: (context, state) => const NoTransitionPage(
                      child: InfoPage(),
                    ),
                    routes: const [],
                  ),
                ],
              ),
              StatefulShellBranch(
                navigatorKey: _shellNavigatorDKey,
                routes: [
                  GoRoute(
                    path: '/profile',
                    name: AppRoute.profilePage.name,
                    pageBuilder: (context, state) => NoTransitionPage(
                      child: ProfilePage(),
                    ),
                    routes: const [],
                  ),
                ],
              ),
            ]),
      ],
      errorBuilder: (context, state) => const NotFoundScreen(),
    );
  },
);

class ScaffoldWithNestedNavigation extends ConsumerStatefulWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey('ScaffoldWithNestedNavigation'));

  @override
  ConsumerState<ScaffoldWithNestedNavigation> createState() =>
      _ScaffoldWithNestedNavigationState();
}

class _ScaffoldWithNestedNavigationState
    extends ConsumerState<ScaffoldWithNestedNavigation> {
  void _goBranch(int index) {
    setState(() {
      ref.watch(whatsViewOnMapStateProvider.notifier).state = '';
      ref.watch(latitudeListOnMapStateProvider.notifier).state = [];
      ref.watch(longitudeListOnMapStateProvider.notifier).state = [];
    });
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: widget.navigationShell,
      bottomNavigationBar: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.only(bottom: 12, left: 16, right: 16),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: NavigationBar(
            backgroundColor: Colors.white,
            indicatorColor: Colors.transparent,
            selectedIndex: widget.navigationShell.currentIndex,
            destinations: const [
              NavigationBarItem(
                label: 'Главная',
                icon: Icons.home,
              ),
              NavigationBarItem(
                label: 'Карта',
                icon: Icons.map,
              ),
              NavigationBarItem(
                label: 'Инфо',
                icon: Icons.info_outline,
              ),
              NavigationBarItem(
                label: 'Профиль',
                icon: Icons.person,
              ),
            ],
            onDestinationSelected: _goBranch,
          ),
        ),
      ),
    );
  }
}
