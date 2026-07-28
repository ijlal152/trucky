part of 'widget_imports.dart';

class TextFieldValidationError extends StatelessWidget {
  final String requiredParameter;
  final bool isValid;

  const TextFieldValidationError({
    super.key,
    required this.requiredParameter,
    required this.isValid,
  });

  @override
  Widget build(BuildContext context) {
    if (isValid) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.only(top: 8.h, left: 4.w),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: LabelWidget(
          text: requiredParameter,
          textSize: 12.sp,
          fontWeight: FontWeight.w400,
          textColor: AppColors.error,
        ),
      ),
    );
  }
}
