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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w).copyWith(top: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LabelWidget(
            text: title,
            textSize: 17.sp,
            textColor: Colors.white.withValues(alpha: 0.85),
            fontWeight: FontWeight.w600,
          ),
          Text.rich(
            TextSpan(
              text: hideBalance ? "*****" : "\$ ",
              style: TextStyle(
                fontSize: balance.length > 20 ? 25.sp : 36.sp,
                color: Colors.white.withValues(alpha: 0.85),
                fontWeight: FontWeight.w500,
              ),
              children: [
                TextSpan(
                  text: hideBalance ? "" : balance,
                  style: TextStyle(
                    fontSize: balance.length > 20 ? 25.sp : 36.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
