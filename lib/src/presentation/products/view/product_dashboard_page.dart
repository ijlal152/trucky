import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:trucky/common/widgets/widget_imports.dart';
import 'package:trucky/src/data/models/product_model.dart';
import 'package:trucky/src/presentation/routes/app_routes.dart';

import '../bloc/products_bloc.dart';

class ProductDashboardPage extends StatelessWidget {
  final String? productId;

  const ProductDashboardPage({super.key, this.productId});

  ProductModel? _findProduct(BuildContext context) {
    final state = context.read<ProductsBloc>().state;
    if (productId == null) return null;
    try {
      return state.products.firstWhere((p) => p.id == productId);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        final product = _findProduct(context);
        final cs = Theme.of(context).colorScheme;

        if (product == null) {
          return CustomScaffold(
            appBar: CustomAppBar(title: "Product Details"),
            body: Center(
              child: LabelWidget(text: "Product not found", textSize: 16.sp),
            ),
          );
        }

        return CustomScaffold(
          extendBodyBehindAppBar: true,
          appBar: CustomAppBar(
            leadingIconColor: Colors.white,
            foregroundColor: Colors.white,
            backgroundColor: Colors.transparent,
            title: product.productName,
            actions: [
              // ── Visibility toggle ───────────────────────────────
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
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
              // ── Popup menu (Edit / Delete) ──────────────────────
              PopupMenuButton<int>(
                icon: Icon(Icons.more_vert, color: Colors.white, size: 24.h),
                color: cs.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                onSelected: (value) {
                  if (value == 1) {
                    // Edit → navigate to add product page
                    context.goNamed(AppRoutes.addProduct.name);
                  } else if (value == 2) {
                    // Delete
                    // TODO: Show confirmation dialog then delete
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 1,
                    child: Row(
                      children: [
                        Icon(Icons.edit_outlined, size: 20.sp),
                        SizedBox(width: 8.w),
                        const Text("Edit"),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete_outline_rounded,
                          size: 20.sp,
                          color: Colors.redAccent,
                        ),
                        SizedBox(width: 8.w),
                        const Text("Delete"),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          body: SizedBox(
            width: double.infinity,
            child: Stack(
              children: [
                // ── Blue header background ────────────────────────
                Positioned.fill(
                  child: SvgPicture.asset(
                    "assets/svgs/blueBackground.svg",
                    fit: BoxFit.cover,
                  ),
                ),

                // ── Content ────────────────────────────────────────
                Padding(
                  padding: EdgeInsets.only(top: 110.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // ── Product info card ───────────────────────
                      _ProductInfoHeader(
                        product: product,
                        hideBalance: state.hideBalance,
                      ),
                      30.verticalSpace,

                      // ── Transactions sheet ──────────────────────
                      Expanded(
                        child: ContentSheet(
                          filterIconOnTap: () {},
                          searchIconOnTap: () {},
                          contentWidget: _buildTransactionList(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTransactionList(BuildContext context) {
    // TODO: Replace with actual transaction history from database
    final cs = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 40.h),
        child: Column(
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 48.sp,
              color: cs.onSurfaceVariant,
            ),
            12.verticalSpace,
            LabelWidget(
              text: "No transactions yet",
              textSize: 15.sp,
              textColor: cs.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
//  Product info header widget
// ═══════════════════════════════════════════════════════════════════════════════

class _ProductInfoHeader extends StatelessWidget {
  final ProductModel product;
  final bool hideBalance;

  const _ProductInfoHeader({required this.product, required this.hideBalance});

  int get _availableStock => product.initialQuantity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Left: Product image + price ──────────────────────
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 90.h,
                height: 90.h,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14.r),
                  child: product.productImage != null
                      ? Image.asset(product.productImage!, fit: BoxFit.cover)
                      : Icon(
                          Icons.shopping_bag_outlined,
                          color: Colors.white70,
                          size: 40.sp,
                        ),
                ),
              ),
              10.verticalSpace,
              LabelWidget(
                text: "Price",
                textColor: Colors.white70,
                textSize: 14.sp,
              ),
              Row(
                children: [
                  LabelWidget(
                    text: "\$${product.sellingPrice.toStringAsFixed(2)}",
                    textColor: Colors.white,
                    textSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ],
          ),

          // ── Right: Stock available + Stock value ─────────────
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              LabelWidget(
                text: "Stock Available",
                textColor: Colors.white70,
                textSize: 14.sp,
              ),
              4.verticalSpace,
              LabelWidget(
                text: "$_availableStock Pcs",
                textColor: Colors.white,
                textSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
              if (product.quantityPerPackage > 0) ...[
                2.verticalSpace,
                LabelWidget(
                  text: _formatStockDetails(
                    _availableStock,
                    product.quantityPerPackage,
                  ),
                  textColor: Colors.white70,
                  textSize: 14.sp,
                ),
              ],
              20.verticalSpace,
              LabelWidget(
                text: "Stock Value",
                textColor: Colors.white70,
                textSize: 14.sp,
              ),
              4.verticalSpace,
              LabelWidget(
                text: hideBalance
                    ? "*****"
                    : "\$${(product.purchasePrice * _availableStock).toStringAsFixed(2)}",
                textColor: Colors.white,
                textSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatStockDetails(int totalUnits, int unitsPerPackage) {
    if (unitsPerPackage <= 0) return '$totalUnits Pcs';
    final fullPackages = totalUnits ~/ unitsPerPackage;
    final extraUnits = totalUnits % unitsPerPackage;
    if (extraUnits == 0) {
      return '($fullPackages\u00d7$unitsPerPackage)';
    }
    return '($fullPackages\u00d7$unitsPerPackage+$extraUnits)';
  }
}
