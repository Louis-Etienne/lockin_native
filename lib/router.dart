
import 'package:lockin_native_2/components/scaffold_navbar.dart';
import 'package:lockin_native_2/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lockin_native_2/screens/auth_screen.dart';
import 'package:lockin_native_2/screens/lock_in_screen.dart';
import 'package:lockin_native_2/screens/profile_screen.dart';
import 'package:lockin_native_2/screens/schedule_screen.dart';
import 'package:lockin_native_2/screens/stats_screen.dart';

final routerProvider = Provider<GoRouter>((ref){
  final auth = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state){
      final isAuthPage = state.matchedLocation == "/login";

      final isAuthenticated = auth.value?.isAuthenticated ?? false;

      if (!isAuthenticated) {
        return isAuthPage ? null : "/login";
      }

      if (isAuthPage){
        return "/";
      }

      return null;
    },
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell){
          return ScaffoldNavbar(navigationShell: navigationShell);
        },

        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/",
                builder: (context, state) => const LockInScreen(),
              ),
            ]
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/schedule",
                builder: (context, state) => const ScheduleScreen(),
              )
            ]
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/stats",
                builder: (context, state) => const StatsScreen(),
              )
            ]
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/profile",
                builder: (context, state) => const ProfileScreen(),
              )
            ]
          )
        ]
      ),
      GoRoute(
        path: "/login",
        builder: (context, state) => const AuthScreen()
      )
    ]
  );

});