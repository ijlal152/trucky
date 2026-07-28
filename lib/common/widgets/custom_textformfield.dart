part of 'widget_imports.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final String? svgPrefixIcon;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final bool obscureText;
  final bool readOnly;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final int? minLines;
  final Color? fillColor;
  final Color? borderColor;
  final bool enabled;

  const CustomTextFormField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.svgPrefixIcon,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.obscureText = false,
    this.readOnly = false,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.focusNode,
    this.textInputAction,
    this.maxLines = 1,
    this.minLines,
    this.fillColor,
    this.borderColor,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      obscureText: obscureText,
      readOnly: readOnly,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      textInputAction: textInputAction,
      maxLines: maxLines,
      minLines: minLines,
      enabled: enabled,
      style: TextStyle(fontSize: 14.sp),
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        prefixIcon: svgPrefixIcon != null
            ? Padding(
                padding: EdgeInsets.all(14.w),
                child: SvgPicture.asset(
                  svgPrefixIcon!,
                  width: 20.w,
                  height: 20.h,
                ),
              )
            : prefixIcon != null
            ? Icon(prefixIcon, size: 22.sp)
            : null,
        suffixIcon: suffixIcon != null
            ? IconButton(
                onPressed: onSuffixTap,
                icon: Icon(suffixIcon, size: 22.sp),
              )
            : null,
        filled: true,
        fillColor: fillColor ?? Colors.grey.shade100,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: borderColor ?? Colors.grey.shade300,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(
            color: AppColors.primaryBlue,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
        hintStyle: TextStyle(color: AppColors.hintLight, fontSize: 14.sp),
        labelStyle: TextStyle(
          color: AppColors.textSecondaryLight,
          fontSize: 14.sp,
        ),
        errorStyle: TextStyle(fontSize: 12.sp),
      ),
    );
  }
}
