import 'package:flutter/material.dart';

/// App color palette derived from the Trucky design.
///
/// Two color schemes are defined: [AppColors.light] and [AppColors.dark].
class AppColors {
  AppColors._();

  // ---------------------------------------------------------------------------
  // Brand colors
  // ---------------------------------------------------------------------------

  /// Primary blue used across buttons, FABs, app bars, and accents.
  static const Color primaryBlue = Color(0xFF1E88E5);

  /// Slightly darker shade for pressed/hover states.
  static const Color primaryBlueDark = Color(0xFF1565C0);

  /// Lighter shade used as soft accent backgrounds.
  static const Color primaryBlueLight = Color(0xFFE3F2FD);

  static const Color buttonPrimaryLight = Color(0xFF2B88D8);

  /// Foreground (text/icon) color on top of [buttonPrimaryLight].
  static const Color onButtonPrimaryLight = Color(0xFFFFFFFF);

  /// Disabled button background in light mode.
  static const Color buttonDisabledLight = Color(0xFFE8EBEE);

  /// Foreground (text/icon) color on top of [buttonDisabledLight].
  static const Color onButtonDisabledLight = Color(0xFF6B7280);

  // ---------------------------------------------------------------------------
  // Neutral colors
  // ---------------------------------------------------------------------------

  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);

  /// Light page background.
  static const Color backgroundLight = Color(0xFFF5F7FA);

  /// Dark page background.
  static const Color backgroundDark = Color(0xFF121212);

  /// Surface for cards/elevated panels in light mode.
  static const Color surfaceLight = Color(0xFFFFFFFF);

  /// Surface for cards/elevated panels in dark mode.
  static const Color surfaceDark = Color(0xFF1E1E1E);

  // ---------------------------------------------------------------------------
  // Text colors
  // ---------------------------------------------------------------------------

  /// Primary text in light mode.
  static const Color textPrimaryLight = Color(0xFF000000);

  /// Primary text in dark mode.
  static const Color textPrimaryDark = Color(0xFFFFFFFF);

  /// Secondary/muted text (e.g. prices under product names).
  static const Color textSecondaryLight = Color(0xFF6B7280);
  static const Color textSecondaryDark = Color(0xFFB0B0B0);

  /// Hint/placeholder text inside input fields.
  static const Color hintLight = Color(0xFF9E9E9E);
  static const Color hintDark = Color(0xFF7A7A7A);

  // ---------------------------------------------------------------------------
  // Borders & dividers
  // ---------------------------------------------------------------------------

  static const Color borderLight = Color(0xFFE0E0E0);
  static const Color borderDark = Color(0xFF2C2C2C);

  static const Color dividerLight = Color(0xFFEEEEEE);
  static const Color dividerDark = Color(0xFF2C2C2C);

  // ---------------------------------------------------------------------------
  // Semantic colors
  // ---------------------------------------------------------------------------

  /// Success — used for positive quantities (e.g. "10 x", "120 x").
  static const Color success = Color(0xFF22C55E);

  /// Error — used for zero/negative quantities or destructive actions.
  static const Color error = Color(0xFFEF4444);

  /// Warning — used for low stock warnings.
  static const Color warning = Color(0xFFF59E0B);

  /// Info — informational accents.
  static const Color info = Color(0xFF3B82F6);

  // ---------------------------------------------------------------------------
  // Gradients
  // ---------------------------------------------------------------------------

  /// Linear gradient used on hero cards (e.g. Total Stock Value header).
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1E88E5), Color(0xFF1565C0)],
  );

  /// Subtle light gradient used as the dashboard sheet / content area background.
  static const LinearGradient sheetBackgroundGradientLight = LinearGradient(
    begin: Alignment(0.00, -1.00),
    end: Alignment(0, 1),
    colors: [Color(0xFFE8EBF5), Color(0xFFFBFCFF)],
  );

  /// Dark variant of the sheet background gradient.
  static const LinearGradient sheetBackgroundGradientDark = LinearGradient(
    begin: Alignment(0.00, -1.00),
    end: Alignment(0, 1),
    colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
  );

  // ---------------------------------------------------------------------------
  // ColorScheme presets
  // ---------------------------------------------------------------------------

  /// Material 3 [ColorScheme] for light theme.
  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: primaryBlue,
    onPrimary: white,
    primaryContainer: primaryBlueLight,
    onPrimaryContainer: primaryBlueDark,
    secondary: primaryBlue,
    onSecondary: white,
    secondaryContainer: primaryBlueLight,
    onSecondaryContainer: primaryBlueDark,
    tertiary: success,
    onTertiary: white,
    tertiaryContainer: Color(0xFFD1FAE5),
    onTertiaryContainer: Color(0xFF065F46),
    error: error,
    onError: white,
    errorContainer: Color(0xFFFEE2E2),
    onErrorContainer: Color(0xFF7F1D1D),
    surface: surfaceLight,
    onSurface: textPrimaryLight,
    surfaceContainerHighest: backgroundLight,
    onSurfaceVariant: textSecondaryLight,
    outline: borderLight,
    outlineVariant: dividerLight,
    shadow: Color(0x1A000000),
    scrim: Color(0x66000000),
    inverseSurface: textPrimaryLight,
    onInverseSurface: surfaceLight,
    inversePrimary: primaryBlueLight,
  );

  /// Material 3 [ColorScheme] for dark theme.
  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: primaryBlue,
    onPrimary: white,
    primaryContainer: Color(0xFF0D47A1),
    onPrimaryContainer: primaryBlueLight,
    secondary: primaryBlue,
    onSecondary: white,
    secondaryContainer: Color(0xFF0D47A1),
    onSecondaryContainer: primaryBlueLight,
    tertiary: success,
    onTertiary: white,
    tertiaryContainer: Color(0xFF064E3B),
    onTertiaryContainer: Color(0xFFD1FAE5),
    error: error,
    onError: white,
    errorContainer: Color(0xFF7F1D1D),
    onErrorContainer: Color(0xFFFEE2E2),
    surface: surfaceDark,
    onSurface: textPrimaryDark,
    surfaceContainerHighest: Color(0xFF2A2A2A),
    onSurfaceVariant: textSecondaryDark,
    outline: borderDark,
    outlineVariant: dividerDark,
    shadow: Color(0x33000000),
    scrim: Color(0x99000000),
    inverseSurface: textPrimaryDark,
    onInverseSurface: surfaceDark,
    inversePrimary: primaryBlueDark,
  );
}
