part of 'widget_imports.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final Color? textColor;
  final double? textSize;
  final FontWeight? fontWeight;
  final TextAlign textAlign;

  const CustomTextButton({
    super.key,
    required this.text,
    this.onTap,
    this.textColor,
    this.textSize,
    this.fontWeight,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: LabelWidget(
        text: text,
        textSize: textSize ?? 15.sp,
        fontWeight: fontWeight ?? FontWeight.w600,
        textColor: textColor ?? Theme.of(context).colorScheme.primary,
        textAlign: textAlign,
      ),
    );
  }
}
