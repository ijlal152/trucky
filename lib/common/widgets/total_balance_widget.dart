part of 'widget_imports.dart';

class TotalBalanceWidget extends StatelessWidget {
  final String title;
  final String balance;
  final bool hideBalance;

  const TotalBalanceWidget({
    super.key,
    required this.title,
    required this.balance,
    this.hideBalance = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        gradient: isDark
            ? const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
              )
            : AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlue.withValues(alpha: 0.3),
            blurRadius: 12.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LabelWidget(
                text: title,
                textSize: 14.sp,
                textColor: Colors.white.withValues(alpha: 0.85),
                fontWeight: FontWeight.w500,
              ),
              4.verticalSpace,
              LabelWidget(
                text: hideBalance ? "*****" : "\$$balance",
                textSize: 24.sp,
                textColor: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
          // Optional: add a small icon or chart decoration
        ],
      ),
    );
  }
}
