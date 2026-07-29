import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:trucky/common/widgets/widget_imports.dart';
import 'package:trucky/src/data/models/product_model.dart';
import 'package:trucky/src/data/models/product_transaction_model.dart';
import 'package:trucky/src/presentation/routes/app_routes.dart';

import '../bloc/products_bloc.dart';

class ProductDashboardPage extends StatefulWidget {
  final String? productId;

  const ProductDashboardPage({super.key, this.productId});

  @override
  State<ProductDashboardPage> createState() => _ProductDashboardPageState();
}

class _ProductDashboardPageState extends State<ProductDashboardPage> {
  @override
  void initState() {
    super.initState();
    if (widget.productId != null) {
      context.read<ProductsBloc>().add(
        LoadProductTransactions(productId: widget.productId!),
      );
    }
  }

  ProductModel? _findProduct(List<ProductModel> products) {
    if (widget.productId == null) return null;
    try {
      return products.firstWhere((p) => p.id == widget.productId);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        final product = _findProduct(state.products);
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
                    context.goNamed(AppRoutes.addProduct.name);
                  } else if (value == 2) {
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
                      // ── Product info header ─────────────────────
                      _ProductInfoHeader(
                        product: product,
                        hideBalance: state.hideBalance,
                        transactions: state.transactions,
                      ),
                      30.verticalSpace,

                      // ── Stats row (Sold / Purchased) ─────────────
                      _StatsRow(
                        totalSold: state.totalSold,
                        totalPurchased: state.totalPurchased,
                      ),
                      16.verticalSpace,

                      // ── Transactions sheet ──────────────────────
                      Expanded(
                        child: ContentSheet(
                          filterIconOnTap: () {},
                          searchIconOnTap: () {},
                          contentWidget: _TransactionList(
                            transactions: state.transactions,
                          ),
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
}

// ═══════════════════════════════════════════════════════════════════════════════
//  Stats row — Sold / Purchased summary
// ═══════════════════════════════════════════════════════════════════════════════
class _StatsRow extends StatelessWidget {
  final int totalSold;
  final int totalPurchased;

  const _StatsRow({required this.totalSold, required this.totalPurchased});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          _StatChip(
            label: 'Total Sold',
            value: '$totalSold units',
            icon: Icons.shopping_cart_outlined,
            color: Colors.greenAccent,
          ),
          SizedBox(width: 12.w),
          _StatChip(
            label: 'Total Purchased',
            value: '$totalPurchased units',
            icon: Icons.receipt_long_outlined,
            color: Colors.orangeAccent,
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatChip({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: cs.surfaceContainerHighest.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20.sp, color: color),
            SizedBox(width: 8.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LabelWidget(
                  text: label,
                  textSize: 11.sp,
                  textColor: cs.onSurfaceVariant,
                ),
                LabelWidget(
                  text: value,
                  textSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  textColor: cs.onSurface,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
//  Transaction list
// ═══════════════════════════════════════════════════════════════════════════════
class _TransactionList extends StatelessWidget {
  final List<ProductTransactionModel> transactions;

  const _TransactionList({required this.transactions});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    if (transactions.isEmpty) {
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

    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: transactions.length,
      separatorBuilder: (_, __) => Divider(
        height: 1,
        indent: 16.w,
        endIndent: 16.w,
        color: cs.outlineVariant,
      ),
      itemBuilder: (context, index) {
        final tx = transactions[index];
        return _TransactionItem(transaction: tx);
      },
    );
  }
}

class _TransactionItem extends StatelessWidget {
  final ProductTransactionModel transaction;

  const _TransactionItem({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isIncoming = transaction.isIncoming;
    final icon = isIncoming
        ? Icons.arrow_downward_rounded
        : Icons.arrow_upward_rounded;
    final iconColor = isIncoming ? Colors.green : Colors.redAccent;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        children: [
          // Type icon
          Container(
            width: 36.h,
            height: 36.h,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(icon, size: 18.sp, color: iconColor),
          ),
          12.horizontalSpace,

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LabelWidget(
                  text: transaction.typeLabel,
                  textSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  textColor: cs.onSurface,
                ),
                if (transaction.referenceName != null) ...[
                  2.verticalSpace,
                  LabelWidget(
                    text: transaction.referenceName!,
                    textSize: 12.sp,
                    textColor: cs.onSurfaceVariant,
                  ),
                ],
                2.verticalSpace,
                LabelWidget(
                  text: _formatDate(transaction.date),
                  textSize: 11.sp,
                  textColor: cs.outline,
                ),
              ],
            ),
          ),

          // Quantity
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              LabelWidget(
                text: '${isIncoming ? '+' : ''}${transaction.quantity} units',
                textSize: 14.sp,
                fontWeight: FontWeight.bold,
                textColor: isIncoming ? Colors.green : Colors.redAccent,
              ),
              if (transaction.note != null && transaction.note!.isNotEmpty)
                LabelWidget(
                  text: transaction.note!,
                  textSize: 11.sp,
                  textColor: cs.outline,
                ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime dt) {
    return '${dt.day}/${dt.month}/${dt.year}';
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
//  Product info header widget
// ═══════════════════════════════════════════════════════════════════════════════

class _ProductInfoHeader extends StatelessWidget {
  final ProductModel product;
  final bool hideBalance;
  final List<ProductTransactionModel> transactions;

  const _ProductInfoHeader({
    required this.product,
    required this.hideBalance,
    required this.transactions,
  });

  int get _availableStock => product.computeAvailableStock(transactions);

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
                    : "\$${product.computeStockValue(transactions).toStringAsFixed(2)}",
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
