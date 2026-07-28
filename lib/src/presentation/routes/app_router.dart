import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trucky/src/presentation/routes/app_routes.dart';

import '../authentication/view/sign_in_page.dart';
import '../authentication/view/sign_up_page_one.dart';
import '../authentication/view/sign_up_page_two.dart';
import '../home/view/home_page.dart';
import '../splash/view/splash_page.dart';

class AppRouter {
  AppRouter._();

  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.initialLocation.path,
    routes: [
      GoRoute(
        path: AppRoutes.splash.path,
        name: AppRoutes.splash.name,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoutes.signIn.path,
        name: AppRoutes.signIn.name,
        builder: (context, state) => const SignInPage(),
      ),
      GoRoute(
        path: AppRoutes.signUp.path,
        name: AppRoutes.signUp.name,
        builder: (context, state) => const SignUpPageOne(),
        routes: [
          GoRoute(
            path: AppRoutes.signUpStepTwo.path,
            name: AppRoutes.signUpStepTwo.name,
            builder: (context, state) => const SignUpPageTwo(),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.home.path,
        name: AppRoutes.home.name,
        builder: (context, state) => const HomePage(),
      ),
    ],
  );
}
