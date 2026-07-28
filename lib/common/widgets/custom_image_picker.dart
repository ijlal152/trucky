part of 'widget_imports.dart';

GestureDetector imagePickerOption({
  required BuildContext context,
  required String img,
  required String option,
  required VoidCallback onTap,
}) {
  final colorScheme = Theme.of(context).colorScheme;

  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.2)),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(img, height: 20.h),
          10.horizontalSpace,
          LabelWidget(text: option, textSize: 16.sp),
        ],
      ),
    ),
  );
}
