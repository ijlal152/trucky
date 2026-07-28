part of 'widget_imports.dart';

class CustomBottomSheetContent extends StatelessWidget {
  final Widget child;
  const CustomBottomSheetContent({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return DecoratedContainer(
      enableCustomBorder: true,
      customBorderRadius: BorderRadius.only(
        topLeft: Radius.circular(22.r),
        topRight: Radius.circular(22.r),
      ),
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [const DividerWidget(), child],
      ),
    );
  }
}
