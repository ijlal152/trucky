import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:trucky/common/widgets/widget_imports.dart';
import 'package:trucky/src/data/models/product_model.dart';
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
                          contentWidget: _buildProductList(context, state),
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

  Widget _buildProductList(BuildContext context, ProductsState state) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final products = state.products;

    if (state.status == ProductsStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (products.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.only(top: 60.h),
          child: Column(
            children: [
              Icon(
                Icons.inventory_2_outlined,
                size: 64.sp,
                color: colorScheme.onSurfaceVariant,
              ),
              16.verticalSpace,
              LabelWidget(
                text: "No products yet",
                textSize: 16.sp,
                fontWeight: FontWeight.w500,
                textColor: colorScheme.onSurfaceVariant,
              ),
              8.verticalSpace,
              LabelWidget(
                text: "Tap + to add your first product",
                textSize: 14.sp,
                textColor: colorScheme.outline,
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return _ProductItem(product: product);
      },
      separatorBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Divider(
            color: colorScheme.outlineVariant,
            thickness: 0.5,
            height: 1,
          ),
        );
      },
    );
  }
}

class _ProductItem extends StatelessWidget {
  final ProductModel product;

  const _ProductItem({required this.product});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          // Product image
          Container(
            width: 48.h,
            height: 48.h,
            decoration: BoxDecoration(
              color: cs.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: product.productImage != null
                  ? Image.asset(product.productImage!, fit: BoxFit.cover)
                  : Icon(
                      Icons.shopping_bag_outlined,
                      color: cs.onSurfaceVariant,
                      size: 24.sp,
                    ),
            ),
          ),
          12.horizontalSpace,
          // Product details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LabelWidget(
                  text: product.productName,
                  textSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  textColor: cs.onSurface,
                ),
                4.verticalSpace,
                LabelWidget(
                  text: "Stock: ${product.initialQuantity} units",
                  textSize: 13.sp,
                  textColor: cs.onSurfaceVariant,
                ),
              ],
            ),
          ),
          // Price
          LabelWidget(
            text: "\$${product.sellingPrice.toStringAsFixed(2)}",
            textSize: 15.sp,
            fontWeight: FontWeight.w700,
            textColor: cs.primary,
          ),
        ],
      ),
    );
  }
}
