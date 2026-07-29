part of 'widget_imports.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? width;
  final double? height;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool fullWidth;
  final bool isDisabled;
  final bool enableShadow;

  const CustomElevatedButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.foregroundColor,
    this.width,
    this.height,
    this.prefixIcon,
    this.suffixIcon,
    this.fullWidth = true,
    this.isDisabled = false,
    this.enableShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    // Light mode: brand color #2B88D8 (enabled) and #E8EBEE (disabled).
    // Dark mode: leave the existing colorScheme behavior intact.
    final Color enabledBg = isDark
        ? colorScheme.primary
        : AppColors.buttonPrimaryLight;
    final Color enabledFg = isDark
        ? colorScheme.onPrimary
        : AppColors.onButtonPrimaryLight;
    final Color disabledBg = isDark
        ? colorScheme.surfaceContainerHighest
        : AppColors.buttonDisabledLight;
    final Color disabledFg = isDark
        ? colorScheme.onSurfaceVariant
        : AppColors.onButtonDisabledLight;

    final effectiveBg = isDisabled
        ? (backgroundColor ?? disabledBg)
        : (backgroundColor ?? enabledBg);
    final effectiveFg = isDisabled
        ? (foregroundColor ?? disabledFg)
        : (foregroundColor ?? enabledFg);

    final isInteractive = !isDisabled && onPressed != null;

    return SizedBox(
      width: fullWidth ? double.infinity : width,
      height: height ?? 52.h,
      child: ElevatedButton(
        onPressed: isInteractive ? onPressed : null,

        style: ElevatedButton.styleFrom(
          backgroundColor: effectiveBg,
          foregroundColor: effectiveFg,
          disabledBackgroundColor: effectiveBg,
          disabledForegroundColor: effectiveFg,
          elevation: isDisabled || !enableShadow ? 0 : 4,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.r),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: 22.w,
                height: 22.h,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(effectiveFg),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (prefixIcon != null) ...[
                    prefixIcon!,
                    SizedBox(width: 8.w),
                  ],
                  Text(
                    text,
                    style: TextStyle(
                      fontFamily: 'Inter-SemiBold',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: effectiveFg,
                    ),
                  ),
                  if (suffixIcon != null) ...[
                    SizedBox(width: 8.w),
                    suffixIcon!,
                  ],
                ],
              ),
      ),
    );
  }
}
