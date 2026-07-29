import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:trucky/common/widgets/widget_imports.dart';
import 'package:trucky/src/presentation/products/widgets/all_products_list.dart';
import 'package:trucky/src/presentation/routes/app_routes.dart';

import '../bloc/products_bloc.dart';

class AllProductsPage extends StatefulWidget {
  const AllProductsPage({super.key});

  @override
  State<AllProductsPage> createState() => _AllProductsPageState();
}

class _AllProductsPageState extends State<AllProductsPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductsBloc>().add(const LoadProducts());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        return CustomScaffold(
          extendBodyBehindAppBar: true,
          appBar: CustomAppBar(
            title: "Products",
            leadingIconColor: Colors.white,
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: GestureDetector(
                  onTap: () {
                    context.read<ProductsBloc>().add(
                      const ToggleBalanceVisibility(),
                    );
                  },
                  child: Icon(
                    state.hideBalance
                        ? Icons.visibility_off_rounded
                        : Icons.visibility_rounded,
                    color: Colors.white,
                    size: 24.h,
                  ),
                ),
              ),
            ],
          ),
          body: SizedBox(
            width: double.infinity,
            child: Stack(
              children: [
                // ── Blue header background ──────────────────────────
                Positioned.fill(
                  child: SvgPicture.asset(
                    "assets/svgs/blueBackground.svg",
                    fit: BoxFit.cover,
                  ),
                ),

                // ── Content ──────────────────────────────────────────
                Padding(
                  padding: EdgeInsets.only(top: 140.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Total Stock Value card
                      TotalBalanceWidget(
                        title: "Total Stock Value",
                        hideBalance: state.hideBalance,
                        balance: state.totalStockValue.toStringAsFixed(2),
                      ),
                      40.verticalSpace,

                      // Products list sheet
                      Expanded(
                        child: ContentSheet(
                          sortType: "Old to new",
                          filterIconOnTap: () {
                            // TODO: Implement filter
                          },
                          searchIconOnTap: () {
                            // TODO: Implement search
                          },
                          isBarCodeEnabled: true,
                          contentWidget: AllProductsList(state: state),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: CustomFloatingBtn(
            onTap: () {
              context.goNamed(AppRoutes.addProduct.name);
            },
          ),
        );
      },
    );
  }
}
