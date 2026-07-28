import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/sign-in',
        name: 'signIn',
        builder: (context, state) => const SignInPage(),
      ),
      GoRoute(
        path: '/sign-up',
        name: 'signUp',
        builder: (context, state) => const SignUpPageOne(),
        routes: [
          GoRoute(
            path: 'step-two',
            name: 'signUpStepTwo',
            builder: (context, state) => const SignUpPageTwo(),
          ),
        ],
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
    ],
  );
}
