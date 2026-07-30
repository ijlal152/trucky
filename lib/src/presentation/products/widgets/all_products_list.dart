import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:trucky/common/widgets/widget_imports.dart';
import 'package:trucky/src/data/models/product_model.dart';
import 'package:trucky/src/presentation/products/bloc/products_bloc.dart';
import 'package:trucky/src/presentation/routes/app_routes.dart';

class AllProductsList extends StatelessWidget {
  final ProductsState state;
  const AllProductsList({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
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

    return GestureDetector(
      onTap: () {
        context.pushNamed(
          AppRoutes.productDashboard.name,
          pathParameters: {'productId': product.id},
        );
      },
      child: Padding(
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
                    text: "${product.initialQuantity} x ${product.productName}",
                    textSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    textColor: cs.onSurface,
                  ),
                  4.verticalSpace,
                  LabelWidget(
                    text: "Price: ${product.sellingPrice}",
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
      ),
    );
  }
}
