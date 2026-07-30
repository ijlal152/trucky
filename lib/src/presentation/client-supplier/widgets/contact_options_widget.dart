import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trucky/common/widgets/widget_imports.dart';
import 'package:trucky/core/app_assets/app_assets.dart';

class ContactOptionsWidget extends StatelessWidget {
  final String? phoneNumber;
  final String? gpsLocation;
  final VoidCallback? onCallPressed;
  final VoidCallback? onLocationPressed;
  final String noPhoneError;
  final String noGpsError;

  const ContactOptionsWidget({
    super.key,
    this.phoneNumber,
    this.gpsLocation,
    this.onCallPressed,
    this.onLocationPressed,
    this.noPhoneError = 'No phone number available!',
    this.noGpsError = 'No location available!',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _ContactButton(
            icon: AppAssets.images.callPng,
            label: 'Call',
            onTap: phoneNumber != null && phoneNumber!.isNotEmpty
                ? onCallPressed
                : () => _showSnackBar(context, noPhoneError),
          ),
          SizedBox(width: 30.w),
          _ContactButton(
            icon: AppAssets.images.gpgPng,
            label: 'Location',
            onTap: gpsLocation != null && gpsLocation!.isNotEmpty
                ? onLocationPressed
                : () => _showSnackBar(context, noGpsError),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

class _ContactButton extends StatelessWidget {
  final String icon;
  final String label;
  final VoidCallback? onTap;

  const _ContactButton({
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 56.h,
            width: 56.h,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Center(
              child: Image.asset(
                icon,
                height: 24.h,
                width: 24.h,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          SizedBox(height: 6.h),
          LabelWidget(
            text: label,
            textSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
