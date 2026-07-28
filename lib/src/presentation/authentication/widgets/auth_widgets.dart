import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trucky/common/widgets/widget_imports.dart';

/// Widget to show step indicator (e.g., "Step 1 of 2")
class ShowStepsWidget extends StatelessWidget {
  final String title;

  const ShowStepsWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 8.w),
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: LabelWidget(
        text: title,
        textSize: 13.sp,
        fontWeight: FontWeight.w600,
        fontFamily: 'Inter-SemiBold',
        textColor: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}

/// Widget for "Already have an account? Sign In here" pattern
class AlreadyHaveAccountWidget extends StatelessWidget {
  final String btnText;
  final String text;
  final VoidCallback onTap;

  const AlreadyHaveAccountWidget({
    super.key,
    required this.btnText,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final linkColor = const Color(0xFF0093B9);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LabelWidget(
          text: text,
          fontWeight: FontWeight.w600,
          textSize: 15.sp,
          textColor: linkColor,
        ),
        4.horizontalSpace,
        CustomTextButton(
          text: btnText,
          textColor: linkColor,
          textSize: 15.sp,
          fontWeight: FontWeight.w700,
          onTap: onTap,
        ),
      ],
    );
  }
}

/// Terms of Use and Privacy Policy widget
class TermsOfUseAndPrivacyPolicy extends StatelessWidget {
  const TermsOfUseAndPrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    final linkColor = const Color(0xFF0093B9);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 40.w,
      ).copyWith(top: 10.h, bottom: 20.h),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(
            fontSize: 12.sp,
            fontFamily: 'Inter-Regular',
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          children: [
            TextSpan(text: 'By continuing, you agree to our '),
            TextSpan(
              text: 'Terms of Use',
              style: TextStyle(
                color: linkColor,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
              ),
            ),
            TextSpan(text: ' and '),
            TextSpan(
              text: 'Privacy Policy',
              style: TextStyle(
                color: linkColor,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
              ),
            ),
            TextSpan(text: '.'),
          ],
        ),
      ),
    );
  }
}

/// Password validation widget showing requirements
class PasswordValidationWidget extends StatelessWidget {
  final bool isValidPasswordLength;
  final bool hasUppercaseSymbol;
  final bool hasANumber;

  const PasswordValidationWidget({
    super.key,
    this.isValidPasswordLength = false,
    this.hasUppercaseSymbol = false,
    this.hasANumber = false,
  });

  @override
  Widget build(BuildContext context) {
    final inactiveColor = const Color.fromRGBO(167, 170, 178, 1);
    final activeColor = const Color.fromRGBO(0, 177, 103, 1);
    final textColor = const Color.fromRGBO(92, 97, 111, 1);

    return Column(
      children: [
        _ValidationRow(
          isValid: isValidPasswordLength,
          text: 'Has at least 8 characters',
          inactiveColor: inactiveColor,
          activeColor: activeColor,
          textColor: textColor,
        ),
        8.verticalSpace,
        _ValidationRow(
          isValid: hasUppercaseSymbol,
          text: 'Has an upper case letter or symbol',
          inactiveColor: inactiveColor,
          activeColor: activeColor,
          textColor: textColor,
        ),
        8.verticalSpace,
        _ValidationRow(
          isValid: hasANumber,
          text: 'Has a number',
          inactiveColor: inactiveColor,
          activeColor: activeColor,
          textColor: textColor,
        ),
      ],
    );
  }
}

class _ValidationRow extends StatelessWidget {
  final bool isValid;
  final String text;
  final Color inactiveColor;
  final Color activeColor;
  final Color textColor;

  const _ValidationRow({
    required this.isValid,
    required this.text,
    required this.inactiveColor,
    required this.activeColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.check,
          color: isValid ? activeColor : inactiveColor,
          size: 18.sp,
        ),
        8.horizontalSpace,
        LabelWidget(
          text: text,
          fontWeight: FontWeight.normal,
          textSize: 13.sp,
          textColor: textColor,
        ),
      ],
    );
  }
}
