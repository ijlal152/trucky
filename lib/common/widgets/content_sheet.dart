part of 'widget_imports.dart';

class ContentSheet extends StatelessWidget {
  final VoidCallback filterIconOnTap;
  final VoidCallback searchIconOnTap;
  final bool isSortFeatureEnabled;
  final bool showSearchField;
  final bool isBarCodeEnabled;
  final Widget? contentWidget;
  final Function(String)? onChanged;
  final String sortType;
  final FocusNode? focusNode;
  final TextEditingController? controller;

  const ContentSheet({
    super.key,
    required this.filterIconOnTap,
    required this.searchIconOnTap,
    this.isSortFeatureEnabled = true,
    this.showSearchField = false,
    this.isBarCodeEnabled = false,
    this.onChanged,
    this.sortType = "",
    this.focusNode,
    this.controller,
    this.contentWidget,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
      child: Column(
        children: [
          if (isSortFeatureEnabled)
            searchAndSortWidget(
              filterIconOnTap: filterIconOnTap,
              searchIconOnTap: searchIconOnTap,
              showSearchField: showSearchField,
              onChanged: onChanged,
              sortType: sortType,
              focusNode: focusNode,
              controller: controller,
              enableQr: isBarCodeEnabled,
            ),
          Expanded(child: contentWidget ?? const SizedBox.shrink()),
        ],
      ),
    );
  }
}

Widget searchAndSortWidget({
  required VoidCallback filterIconOnTap,
  required VoidCallback searchIconOnTap,
  Function(String)? onChanged,
  String sortType = "",
  bool showSearchField = false,
  FocusNode? focusNode,
  TextEditingController? controller,
  bool enableQr = false,
}) {
  return Builder(
    builder: (context) {
      final cs = Theme.of(context).colorScheme;

      return Container(
        height: 60.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: cs.surfaceContainerHighest,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r),
            topRight: Radius.circular(30.r),
          ),
          border: Border(
            bottom: BorderSide(color: cs.outlineVariant.withValues(alpha: 0.3)),
          ),
        ),
        child: showSearchField == false
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Filter icon
                  GestureDetector(
                    onTap: filterIconOnTap,
                    child: Icon(
                      Icons.filter_list_rounded,
                      size: 24.h,
                      color: cs.onSurfaceVariant,
                    ),
                  ),

                  // Sort label
                  LabelWidget(
                    text: "Sort By : $sortType",
                    textSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),

                  // Right icons (QR + search)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (enableQr)
                        Icon(
                          Icons.qr_code_scanner_rounded,
                          size: 24.h,
                          color: cs.onSurfaceVariant,
                        ),
                      if (enableQr) 15.horizontalSpace,
                      GestureDetector(
                        onTap: searchIconOnTap,
                        child: Icon(
                          Icons.search_rounded,
                          size: 24.h,
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 15.w, right: 15.w),
                      child: ContentSheetTextField(
                        hintText: "Search by name",
                        fillColor: Colors.transparent,
                        controller: controller,
                        onChanged: onChanged,
                        focusNode: focusNode,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: searchIconOnTap,
                    child: Icon(
                      Icons.cancel_outlined,
                      size: 24.sp,
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
      );
    },
  );
}

// ── Search text field used inside ContentSheet ──────────────────────────────

class ContentSheetTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final String? labelText;
  final TextInputType textInputType;
  final TextInputAction? textInputAction;
  final bool obscure;
  final double height;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final Function()? onEditingComplete;
  final EdgeInsets? contentPadding;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final Widget? suffixIcon;
  final Color? fillColor;
  final Color errorBorderColor;
  final FocusNode? focusNode;

  const ContentSheetTextField({
    super.key,
    this.controller,
    this.hintText = '',
    this.labelText,
    this.textInputType = TextInputType.text,
    this.textInputAction,
    this.obscure = false,
    this.height = 70,
    this.inputFormatters,
    this.validator,
    this.contentPadding,
    this.onEditingComplete,
    this.suffixIcon,
    this.fillColor,
    this.errorBorderColor = Colors.white,
    this.focusNode,
    this.onChanged,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SizedBox(
      height: height.h,
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        focusNode: focusNode,
        obscureText: obscure,
        inputFormatters: inputFormatters,
        validator: validator,
        onEditingComplete: onEditingComplete,
        onFieldSubmitted: onFieldSubmitted,
        keyboardType: textInputType,
        textInputAction: textInputAction,
        style: TextStyle(
          fontSize: 17.sp,
          fontWeight: FontWeight.w500,
          color: cs.onSurface,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          filled: true,
          fillColor: fillColor ?? cs.surfaceContainerHighest,
          hintText: hintText,
          labelText: labelText,
          labelStyle: TextStyle(
            color: cs.onSurfaceVariant,
            fontSize: 17.sp,
            fontWeight: FontWeight.w500,
          ),
          hintStyle: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.w500,
            color: cs.onSurface.withValues(alpha: 0.6),
          ),
          contentPadding: contentPadding,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
