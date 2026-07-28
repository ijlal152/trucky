import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Centralized text styles for the Trucky app.
///
/// Use these via `Theme.of(context).textTheme.<style>` or directly
/// with `AppTextStyles.headlineLarge`.
class AppTextStyles {
  AppTextStyles._();

  // ---------------------------------------------------------------------------
  // Display & headlines — for big numbers like "525,000.00 DZD"
  // ---------------------------------------------------------------------------

  static const TextStyle displayLarge = TextStyle(
    fontFamily: 'Gilroy-Bold',
    fontSize: 36,
    fontWeight: FontWeight.w800,
    height: 1.2,
    color: AppColors.white,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: 'Gilroy-Bold',
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.25,
  );

  static const TextStyle displaySmall = TextStyle(
    fontFamily: 'Gilroy-Bold',
    fontSize: 22,
    fontWeight: FontWeight.w700,
    height: 1.3,
  );

  static const TextStyle headlineLarge = TextStyle(
    fontFamily: 'Gilroy-Bold',
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.3,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: 'Gilroy-Bold',
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontFamily: 'Gilroy-Bold',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  // ---------------------------------------------------------------------------
  // Titles — for app bar titles, card titles, section headings
  // ---------------------------------------------------------------------------

  static const TextStyle titleLarge = TextStyle(
    fontFamily: 'Gilroy-Bold',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: 'Gilroy-Bold',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  static const TextStyle titleSmall = TextStyle(
    fontFamily: 'Gilroy-Bold',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  // ---------------------------------------------------------------------------
  // Body — for descriptions, paragraphs, list rows
  // ---------------------------------------------------------------------------

  static const TextStyle bodyLarge = TextStyle(
    fontFamily: 'Gilroy-Regular',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: 'Gilroy-Regular',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: 'Gilroy-Regular',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );

  // ---------------------------------------------------------------------------
  // Labels — for buttons, chips, captions
  // ---------------------------------------------------------------------------

  static const TextStyle labelLarge = TextStyle(
    fontFamily: 'Gilroy-Bold',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: 0.2,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: 'Gilroy-Bold',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: 0.2,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: 'Gilroy-Bold',
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: 0.2,
  );

  // ---------------------------------------------------------------------------
  // Specialized styles
  // ---------------------------------------------------------------------------

  /// App bar title.
  static const TextStyle appBarTitle = TextStyle(
    fontFamily: 'Gilroy-Bold',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  /// Input field text.
  static const TextStyle inputText = TextStyle(
    fontFamily: 'Gilroy-Regular',
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );

  /// Input field hint.
  static const TextStyle inputHint = TextStyle(
    fontFamily: 'Gilroy-Regular',
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.hintLight,
  );

  /// Primary CTA button label.
  static const TextStyle buttonPrimary = TextStyle(
    fontFamily: 'Gilroy-Bold',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    letterSpacing: 0.2,
  );

  /// Section/label text on hero cards (e.g. "Total Stock Value").
  static const TextStyle heroCardLabel = TextStyle(
    fontFamily: 'Gilroy-Regular',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
    height: 1.4,
  );
}
