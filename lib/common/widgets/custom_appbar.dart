part of 'widget_imports.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final double elevation;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final PreferredSizeWidget? bottom;
  final double toolbarHeight;
  final VoidCallback? leadingOnTap;
  final Color? leadingIconColor;

  const CustomAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.elevation = 0,
    this.backgroundColor,
    this.foregroundColor,
    this.bottom,
    this.toolbarHeight = kToolbarHeight,
    this.leadingOnTap,
    this.leadingIconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return PreferredSize(
      preferredSize: Size.fromHeight(70.h),
      child: AppBar(
        title: titleWidget ?? (title != null ? Text(title!) : null),
        actions: actions,
        leading: automaticallyImplyLeading == true
            ? IconButton(
                onPressed: () {
                  if (leadingOnTap != null) {
                    leadingOnTap!(); // invoke the callback
                  } else {
                    context.pop(); // default behavior
                  }
                },
                icon: SvgPicture.asset(
                  AppAssets.svgs.backBtnSvg,
                  fit: BoxFit.contain,
                  height: 16.h,
                  width: 16.w,
                  colorFilter: ColorFilter.mode(
                    leadingIconColor ?? Colors.black,
                    BlendMode.srcIn,
                  ),
                ),
              )
            : null,
        automaticallyImplyLeading: automaticallyImplyLeading,
        elevation: elevation,
        forceMaterialTransparency: true,
        backgroundColor: backgroundColor ?? colorScheme.primary,
        foregroundColor: foregroundColor ?? colorScheme.onPrimary,
        iconTheme: IconThemeData(
          color: foregroundColor ?? colorScheme.onPrimary,
        ),
        actionsIconTheme: IconThemeData(
          color: foregroundColor ?? colorScheme.onPrimary,
        ),
        bottom: bottom,
        toolbarHeight: toolbarHeight,
        centerTitle: true,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight.h);
  // Size get preferredSize =>
  //     Size.fromHeight(toolbarHeight + (bottom?.preferredSize.height ?? 0));
}
