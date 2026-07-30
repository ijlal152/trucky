import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trucky/common/widgets/widget_imports.dart';
import 'package:trucky/core/app_assets/app_assets.dart';
import 'package:trucky/core/theme/app_colors.dart';

class TransactionListWidget extends StatelessWidget {
  final List<Map<String, dynamic>> transactions;
  final String emptyMessage;

  const TransactionListWidget({
    super.key,
    required this.transactions,
    this.emptyMessage = 'No transactions found',
  });

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return Center(
        child: LabelWidget(
          text: emptyMessage,
          textSize: 15.sp,
          textColor: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: transactions.length,
      separatorBuilder: (context, index) =>
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: dividerWidget(context),
          ),
      itemBuilder: (context, index) {
        final txn = transactions[index];
        return _TransactionTile(transaction: txn);
      },
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final Map<String, dynamic> transaction;

  const _TransactionTile({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final paymentType = transaction['paymentType'] as String? ?? 'Sale';
    final amount = transaction['amount'] as String? ?? '0';
    final date = transaction['date'] as String? ?? '';
    final note = transaction['note'] as String?;

    final isPositive = _isPositivePaymentType(paymentType);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          Container(
            height: 40.h,
            width: 40.h,
            decoration: BoxDecoration(
              color: isPositive
                  ? AppColors.success.withValues(alpha: 0.1)
                  : AppColors.error.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Center(
              child: Image.asset(
                _getPaymentTypeIcon(paymentType),
                height: 20.h,
                width: 20.h,
                color: isPositive ? AppColors.success : AppColors.error,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LabelWidget(
                  text: paymentType,
                  textSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
                if (date.isNotEmpty) ...[
                  SizedBox(height: 2.h),
                  LabelWidget(
                    text: date,
                    textSize: 12.sp,
                    textColor: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ],
                if (note != null && note.isNotEmpty) ...[
                  SizedBox(height: 2.h),
                  LabelWidget(
                    text: note,
                    textSize: 12.sp,
                    textColor: Theme.of(context).colorScheme.onSurfaceVariant,
                    maxLines: 1,
                  ),
                ],
              ],
            ),
          ),
          LabelWidget(
            text: '\$$amount',
            textSize: 16.sp,
            fontWeight: FontWeight.bold,
            textColor: isPositive ? AppColors.success : AppColors.error,
          ),
        ],
      ),
    );
  }

  bool _isPositivePaymentType(String type) {
    switch (type.toLowerCase()) {
      case 'sale':
      case 'payment':
      case 'initial balance':
        return true;
      case 'purchase':
      case 'return':
      case 'refund':
      case 'expense':
        return false;
      default:
        return true;
    }
  }

  String _getPaymentTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'sale':
        return AppAssets.images.sellsIconOne;
      case 'payment':
        return AppAssets.images.paymentIconOne;
      case 'purchase':
        return AppAssets.images.supplierIcon;
      case 'return':
        return AppAssets.images.returnIconOne;
      case 'refund':
        return AppAssets.images.refundIconOne;
      case 'initial balance':
        return AppAssets.images.checkIconGreen;
      default:
        return AppAssets.images.sellsIconOne;
    }
  }
}
