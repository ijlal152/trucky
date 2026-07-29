part of 'widget_imports.dart';

class ContentSheet extends StatelessWidget {
  final Widget contentWidget;
  final String? sortType;
  final VoidCallback? filterIconOnTap;
  final VoidCallback? searchIconOnTap;
  final bool isBarCodeEnabled;

  const ContentSheet({
    super.key,
    required this.contentWidget,
    this.sortType,
    this.filterIconOnTap,
    this.searchIconOnTap,
    this.isBarCodeEnabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.r),
          topRight: Radius.circular(32.r),
        ),
      ),
      child: Column(
        children: [
          // ── Header with sort/filter/search bar ────────────────────
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
            child: Row(
              children: [
                if (sortType != null) ...[
                  LabelWidget(
                    text: sortType!,
                    textSize: 13.sp,
                    textColor: colorScheme.onSurfaceVariant,
                  ),
                  SizedBox(width: 8.w),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 18.sp,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ],
                const Spacer(),
                if (filterIconOnTap != null)
                  GestureDetector(
                    onTap: filterIconOnTap,
                    child: Icon(
                      Icons.filter_list_rounded,
                      size: 22.sp,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                if (searchIconOnTap != null) ...[
                  SizedBox(width: 12.w),
                  GestureDetector(
                    onTap: searchIconOnTap,
                    child: Icon(
                      Icons.search_rounded,
                      size: 22.sp,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
                if (isBarCodeEnabled) ...[
                  SizedBox(width: 12.w),
                  GestureDetector(
                    onTap: searchIconOnTap,
                    child: Icon(
                      Icons.qr_code_scanner_rounded,
                      size: 22.sp,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),

          // ── Divider ────────────────────────────────────────────────
          Divider(color: colorScheme.outlineVariant, thickness: 0.5, height: 1),

          // ── Content ────────────────────────────────────────────────
          Expanded(child: contentWidget),
        ],
      ),
    );
  }
}
