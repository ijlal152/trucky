part of 'widget_imports.dart';

GestureDetector btmSheetPaymentTypeItem({
  required String icon,
  required String itemName,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(icon, height: 50.h),
        5.verticalSpace,
        LabelWidget(text: itemName),
      ],
    ),
  );
}
