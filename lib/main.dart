import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/database_adapters/hive_adapters.dart';
import 'core/di/service_locator.dart';
import 'core/theme/app_theme.dart';
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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

  // ── Hive initialization (adapters + boxes) ────────────────────────
  await initHive();

  // ── Dependency Injection ──────────────────────────────────────────
  await configureDependencies();

  await Future.delayed(const Duration(milliseconds: 150));
  runApp(const TruckyApp());
}

class TruckyApp extends StatelessWidget {
  const TruckyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<SplashBloc>()),
        BlocProvider(create: (_) => sl<AuthBloc>()),
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
    return ScreenUtilInit(
      designSize: const Size(390, 844), // iPhone 14 reference
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Trucky',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: ThemeMode.system,

          // ─── Localization ──────────────────────────────────────────
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('ar', 'SA'),
            Locale('fr', 'FR'),
          ],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            for (final supported in supportedLocales) {
              if (supported.languageCode == locale?.languageCode) {
                return supported;
              }
            }
            return const Locale('en', 'US');
          },

          routerConfig: AppRouter.router,
        );
      },
    );
  }
}
