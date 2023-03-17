import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_example/blocs/auth/auth_bloc.dart';
import 'package:go_router_example/screens/home_screen.dart';
import 'package:go_router_example/screens/login_screen.dart';
import 'package:go_router_example/screens/splash_screen.dart';
import 'package:go_router_example/utils/pref_helper.dart';

import 'blocs/login/login_bloc.dart';

enum Routes {
  splash,
  login,
  home,
}

extension ToPath on Routes {
  String get toPath {
    if (this == Routes.splash) return '/';
    return '/$name';
  }
}

class AppRouter {
  final AuthBloc authBloc;
  final PrefHelper prefHelper;

  AppRouter({
    required this.authBloc,
    required this.prefHelper,
  });

  GoRouter get router => _router;

  late final GoRouter _router = GoRouter(
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    initialLocation: Routes.splash.toPath,
    routes: [
      GoRoute(
        path: Routes.splash.toPath,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: Routes.login.toPath,
        builder: (context, state) => BlocProvider(
          create: (context) => LoginBloc(prefHelper),
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: Routes.home.toPath,
        builder: (context, state) => const HomeScreen(),
      )
    ],
    redirect: (context, state) {
      final authStatus = authBloc.state.status;

      if (authStatus.isAuthenticated) {
        return Routes.home.toPath;
      }

      if (authStatus.isUnauthenticated) {
        return Routes.login.toPath;
      }

      return null;
    },
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((dynamic _) {
      notifyListeners();
    });
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
