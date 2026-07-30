import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trucky/src/presentation/analysis/view/analysis_page.dart';
import 'package:trucky/src/presentation/clients/view/clients_page.dart';
import 'package:trucky/src/presentation/products/view/add_product_page.dart';
import 'package:trucky/src/presentation/products/view/all_products_page.dart';
import 'package:trucky/src/presentation/products/view/product_dashboard_page.dart';
import 'package:trucky/src/presentation/purchases/view/purchases_page.dart';
import 'package:trucky/src/presentation/routes/app_routes.dart';
import 'package:trucky/src/presentation/sales/view/sales_page.dart';
import 'package:trucky/src/presentation/suppliers/view/suppliers_page.dart';
import 'package:trucky/src/presentation/treasury/view/treasury_page.dart';

import '../authentication/view/sign_in_page.dart';
import '../authentication/view/sign_up_page_one.dart';
import '../authentication/view/sign_up_page_two.dart';
import '../home/view/home_page.dart';
import '../settings/view/settings.dart';
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
      GoRoute(
        path: AppRoutes.products.path,
        name: AppRoutes.products.name,
        builder: (context, state) => const AllProductsPage(),
        routes: [
          GoRoute(
            path: AppRoutes.addProduct.path.replaceFirst('/products/', ''),
            name: AppRoutes.addProduct.name,
            builder: (context, state) => const AddProductPage(),
          ),
          GoRoute(
            path: 'dashboard/:productId',
            name: AppRoutes.productDashboard.name,
            builder: (context, state) => ProductDashboardPage(
              productId: state.pathParameters['productId'],
            ),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.sales.path,
        name: AppRoutes.sales.name,
        builder: (context, state) => const SalesPage(),
      ),
      GoRoute(
        path: AppRoutes.purchases.path,
        name: AppRoutes.purchases.name,
        builder: (context, state) => const PurchasesPage(),
      ),
      GoRoute(
        path: AppRoutes.suppliers.path,
        name: AppRoutes.suppliers.name,
        builder: (context, state) => const SuppliersPage(),
      ),
      GoRoute(
        path: AppRoutes.clients.path,
        name: AppRoutes.clients.name,
        builder: (context, state) => const ClientsPage(),
      ),
      GoRoute(
        path: AppRoutes.treasury.path,
        name: AppRoutes.treasury.name,
        builder: (context, state) => const TreasuryPage(),
      ),
      GoRoute(
        path: AppRoutes.analysis.path,
        name: AppRoutes.analysis.name,
        builder: (context, state) => const AnalysisPage(),
      ),
      GoRoute(
        path: AppRoutes.settings.path,
        name: AppRoutes.settings.name,
        builder: (context, state) => const SettingsPage(),
      ),
    ],
  );
}


// extension GoRouterExt on BuildContext {
//   void goToHome() => goNamed(AppRoutes.home.name);
//   void goToSignIn() => goNamed(AppRoutes.signIn.name);
//   // ...
// }