import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/presentation/analytics/bloc/analytics_bloc.dart';
import 'src/presentation/authentication/bloc/auth_bloc.dart';
import 'src/presentation/client-supplier/bloc/client_supplier_bloc.dart';
import 'src/presentation/home/bloc/home_bloc.dart';
import 'src/presentation/products/bloc/products_bloc.dart';
import 'src/presentation/routes/app_router.dart';
import 'src/presentation/sale_purchase/bloc/sale_purchase_bloc.dart';
import 'src/presentation/settings/bloc/settings_bloc.dart';
import 'src/presentation/splash/bloc/splash_bloc.dart';
import 'src/presentation/treasury/bloc/treasury_bloc.dart';

void main() {
  runApp(const TruckyApp());
}

class TruckyApp extends StatelessWidget {
  const TruckyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SplashBloc()),
        BlocProvider(create: (_) => AuthBloc()),
        BlocProvider(create: (_) => HomeBloc()),
        BlocProvider(create: (_) => SettingsBloc()),
        BlocProvider(create: (_) => ClientSupplierBloc()),
        BlocProvider(create: (_) => ProductsBloc()),
        BlocProvider(create: (_) => SalePurchaseBloc()),
        BlocProvider(create: (_) => TreasuryBloc()),
        BlocProvider(create: (_) => AnalyticsBloc()),
      ],
      child: const _AppView(),
    );
  }
}

class _AppView extends StatelessWidget {
  const _AppView();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Trucky',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: AppRouter.router,
    );
  }
}
