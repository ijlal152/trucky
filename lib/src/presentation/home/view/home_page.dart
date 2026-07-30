import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:trucky/common/widgets/widget_imports.dart';
import 'package:trucky/src/presentation/routes/app_routes.dart';

import '../../../../core/theme/app_colors.dart';
import '../bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        // Trigger data load on first build
        if (state.status == HomeStatus.initial) {
          context.read<HomeBloc>().add(const LoadHomeData());
        }

        return PopScope(
          canPop: true,
          child: CustomScaffold(
            body: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Stack(
                children: [
                  // ── Blue header background ──────────────────────────
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: SizedBox(
                      width: double.infinity, // Ensure full width
                      height: 300.h, // Your desired height
                      child: SvgPicture.asset(
                        'assets/svgs/header_background.svg',
                        fit: BoxFit.fill, // Try cover or fill
                      ),
                    ),
                  ),

                  // ── Header content ───────────────────────────────────
                  Positioned(
                    top: 80.h,
                    left: 24.w,
                    right: 24.w,
                    child: _HomeHeader(),
                  ),

                  // ── Dashboard sheet ──────────────────────────────────
                  Positioned(
                    top: 170.h,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                        gradient:
                            Theme.of(context).brightness == Brightness.dark
                            ? AppColors.sheetBackgroundGradientDark
                            : AppColors.sheetBackgroundGradientLight,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.r),
                          topRight: Radius.circular(30.r),
                        ),
                      ),
                      child: _DashboardSheet(state: state),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Header
// ─────────────────────────────────────────────────────────────────────────────

class _HomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            // Avatar placeholder
            Container(
              height: 60.h,
              width: 60.h,
              decoration: const BoxDecoration(
                color: Colors.white24,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.person, size: 28.sp, color: Colors.white),
            ),
            12.horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Trucky',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                4.verticalSpace,
                Text(
                  'Demo Version',
                  style: TextStyle(fontSize: 14.sp, color: Colors.white70),
                ),
              ],
            ),
          ],
        ),
        GestureDetector(
          onTap: () => context.pushNamed(AppRoutes.settings.name),
          child: Icon(
            Icons.settings_outlined,
            size: 26.sp,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Dashboard sheet
// ─────────────────────────────────────────────────────────────────────────────

class _DashboardSheet extends StatelessWidget {
  final HomeState state;

  const _DashboardSheet({required this.state});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final counts = [
      state.saleCount,
      state.purchaseCount,
      state.supplierCount,
      state.clientCount,
      state.productCount,
      0, // Treasury – not implemented yet
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w).copyWith(top: 35.h),
      child: Column(
        children: [
          // First row: Sales, Purchases
          Row(
            children: [
              Expanded(
                child: _buildFeatureCard(
                  icon: "assets/svgs/home-sales.svg",
                  label: 'Sales',
                  count: counts[0],
                  cs: cs,
                  onTap: () => context.pushNamed(AppRoutes.sales.name),
                ),
              ),
              16.horizontalSpace,
              Expanded(
                child: _buildFeatureCard(
                  icon: "assets/svgs/home-purchases.svg",
                  label: 'Purchases',
                  count: counts[1],
                  cs: cs,
                  onTap: () => context.pushNamed(AppRoutes.purchases.name),
                ),
              ),
            ],
          ),
          16.verticalSpace,
          // Second row: Suppliers, Clients
          Row(
            children: [
              Expanded(
                child: _buildFeatureCard(
                  icon: "assets/svgs/home-suppliers.svg",
                  label: 'Suppliers',
                  count: counts[2],
                  cs: cs,
                  onTap: () => context.pushNamed(AppRoutes.suppliers.name),
                ),
              ),
              16.horizontalSpace,
              Expanded(
                child: _buildFeatureCard(
                  icon: "assets/svgs/home-clients.svg",
                  label: 'Clients',
                  count: counts[3],
                  cs: cs,
                  onTap: () => context.pushNamed(AppRoutes.clients.name),
                ),
              ),
            ],
          ),
          16.verticalSpace,
          // Third row: Products, Treasury
          Row(
            children: [
              Expanded(
                child: _buildFeatureCard(
                  icon: "assets/svgs/home-products.svg",
                  label: 'Products',
                  count: counts[4],
                  cs: cs,
                  onTap: () => context.pushNamed(AppRoutes.products.name),
                ),
              ),
              16.horizontalSpace,
              Expanded(
                child: _buildFeatureCard(
                  icon: "assets/svgs/home-treasury.svg",
                  label: 'Treasury',
                  count: counts[5],
                  cs: cs,
                  onTap: () => context.pushNamed(AppRoutes.treasury.name),
                ),
              ),
            ],
          ),
          16.verticalSpace,
          // Analysis – full width
          _buildAnalysisCard(cs, () {
            context.pushNamed(AppRoutes.analysis.name);
          }),
        ],
      ),
    );
  }

  Widget _buildFeatureCard({
    required String icon,
    required String label,
    required int count,
    required ColorScheme cs,
    VoidCallback? onTap,
  }) {
    return Container(
      height: 130.h,
      width: 180.w,
      // padding: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8.r,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(14.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(14.r),
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(icon, height: 48.h),
              5.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    ' ($count) ',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: cs.onSurface,
                    ),
                  ),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnalysisCard(ColorScheme cs, VoidCallback? onTap) {
    return Container(
      height: 130.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(14.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(14.r),
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/svgs/home-analytics.svg", height: 48.h),
              8.verticalSpace,
              Text(
                'Analysis',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: cs.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
