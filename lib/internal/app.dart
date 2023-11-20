import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konar_mobile/core/utils/app_router.dart';
import 'package:konar_mobile/features/login_page/presentation/login_screen.dart';

class KonarMobile extends ConsumerWidget {
  const KonarMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    return MaterialApp.router(
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white70,
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              elevation: 0,
              backgroundColor: Colors.white70,
              unselectedIconTheme: IconThemeData(color: Colors.white),
              selectedIconTheme: IconThemeData(
                color: Color(0xff0D1F61),
              )),
          appBarTheme: const AppBarTheme(
              color: Color(0xff0D1F61),
              titleTextStyle:
                  TextStyle(fontSize: 22, fontWeight: FontWeight.w500))),
    );
  }
}
