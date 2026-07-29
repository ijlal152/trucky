part of 'widget_imports.dart';

class CustomBottomNavBarWidget extends StatelessWidget {
  final Color? navBarColor;
  final EdgeInsets? padding;
  final Widget? widget;
  final double borderRadius;
  const CustomBottomNavBarWidget({
    super.key,
    this.navBarColor,
    this.padding,
    this.borderRadius = 0,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.only(bottom: 30.h),
      decoration: BoxDecoration(
        color: navBarColor ?? Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
        ),
      ),
      child: widget,
    );
  }
}
