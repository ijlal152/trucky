import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_light_theme.dart';

/// Dark theme configuration matching the Trucky design.
class AppDarkTheme {
  AppDarkTheme._();

  static ThemeData get theme => AppLightTheme.theme.copyWith(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    canvasColor: AppColors.backgroundDark,
    cardColor: AppColors.surfaceDark,
    dividerColor: AppColors.dividerDark,
    splashColor: AppColors.primaryBlue.withValues(alpha: 0.12),
    highlightColor: AppColors.primaryBlue.withValues(alpha: 0.08),
    hoverColor: AppColors.primaryBlue.withValues(alpha: 0.08),

    colorScheme: AppColors.darkColorScheme,

    // -------------------------------------------------------------------------
    // Text theme (override colors for dark mode)
    // -------------------------------------------------------------------------
    textTheme: AppLightTheme.theme.textTheme.apply(
      bodyColor: AppColors.textPrimaryDark,
      displayColor: AppColors.textPrimaryDark,
    ),
    primaryTextTheme: AppLightTheme.theme.textTheme.apply(
      bodyColor: AppColors.textPrimaryDark,
      displayColor: AppColors.textPrimaryDark,
    ),

    // -------------------------------------------------------------------------
    // App bar (darker variant for dark mode)
    // -------------------------------------------------------------------------
    appBarTheme: AppLightTheme.theme.appBarTheme.copyWith(
      backgroundColor: AppColors.primaryBlueDark,
      foregroundColor: AppColors.white,
      titleTextStyle: AppLightTheme.theme.appBarTheme.titleTextStyle?.copyWith(
        color: AppColors.white,
      ),
      iconTheme: const IconThemeData(color: AppColors.white),
      actionsIconTheme: const IconThemeData(color: AppColors.white),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    ),

    // -------------------------------------------------------------------------
    // Cards
    // -------------------------------------------------------------------------
    cardTheme: CardThemeData(
      color: AppColors.surfaceDark,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.borderDark, width: 0.5),
      ),
    ),

    // -------------------------------------------------------------------------
    // Elevated buttons
    // -------------------------------------------------------------------------
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.white,
        disabledBackgroundColor: AppColors.primaryBlue.withValues(alpha: 0.4),
        disabledForegroundColor: AppColors.white.withValues(alpha: 0.7),
        elevation: 0,
        minimumSize: const Size(double.infinity, 52),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        textStyle: AppLightTheme.theme.elevatedButtonTheme.style?.textStyle
            ?.resolve({}),
      ),
    ),

    // -------------------------------------------------------------------------
    // Input fields
    // -------------------------------------------------------------------------
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surfaceDark,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      hintStyle: AppLightTheme.theme.inputDecorationTheme.hintStyle?.copyWith(
        color: AppColors.hintDark,
      ),
      labelStyle: AppLightTheme.theme.inputDecorationTheme.labelStyle?.copyWith(
        color: AppColors.textSecondaryDark,
      ),
      floatingLabelStyle: AppLightTheme
          .theme
          .inputDecorationTheme
          .floatingLabelStyle
          ?.copyWith(color: AppColors.primaryBlue),
      helperStyle: AppLightTheme.theme.inputDecorationTheme.helperStyle
          ?.copyWith(color: AppColors.textSecondaryDark),
      errorStyle: AppLightTheme.theme.inputDecorationTheme.errorStyle?.copyWith(
        color: AppColors.error,
      ),
      prefixIconColor: AppColors.textSecondaryDark,
      suffixIconColor: AppColors.textSecondaryDark,
      iconColor: AppColors.textSecondaryDark,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.borderDark, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.borderDark, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primaryBlue, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.error, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.error, width: 1.5),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.borderDark, width: 1),
      ),
    ),

    // -------------------------------------------------------------------------
    // Bottom navigation bar
    // -------------------------------------------------------------------------
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.surfaceDark,
      selectedItemColor: AppColors.primaryBlue,
      unselectedItemColor: AppColors.textSecondaryDark,
      selectedLabelStyle:
          AppLightTheme.theme.bottomNavigationBarTheme.selectedLabelStyle,
      unselectedLabelStyle:
          AppLightTheme.theme.bottomNavigationBarTheme.unselectedLabelStyle,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),

    // -------------------------------------------------------------------------
    // Navigation bar (M3)
    // -------------------------------------------------------------------------
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.surfaceDark,
      indicatorColor: AppColors.primaryBlueDark.withValues(alpha: 0.4),
      labelTextStyle: AppLightTheme.theme.navigationBarTheme.labelTextStyle,
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: AppColors.primaryBlue);
        }
        return const IconThemeData(color: AppColors.textSecondaryDark);
      }),
      elevation: 2,
      height: 70,
    ),

    // -------------------------------------------------------------------------
    // Divider
    // -------------------------------------------------------------------------
    dividerTheme: const DividerThemeData(
      color: AppColors.dividerDark,
      thickness: 0.5,
      space: 0.5,
    ),

    // -------------------------------------------------------------------------
    // Icons
    // -------------------------------------------------------------------------
    iconTheme: const IconThemeData(color: AppColors.textPrimaryDark, size: 24),
    primaryIconTheme: const IconThemeData(color: AppColors.white, size: 24),

    // -------------------------------------------------------------------------
    // Bottom sheet
    // -------------------------------------------------------------------------
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.surfaceDark,
      modalBackgroundColor: AppColors.surfaceDark,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
    ),

    // -------------------------------------------------------------------------
    // Dialog
    // -------------------------------------------------------------------------
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.surfaceDark,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      titleTextStyle: AppLightTheme.theme.dialogTheme.titleTextStyle?.copyWith(
        color: AppColors.textPrimaryDark,
      ),
      contentTextStyle: AppLightTheme.theme.dialogTheme.contentTextStyle
          ?.copyWith(color: AppColors.textPrimaryDark),
    ),

    // -------------------------------------------------------------------------
    // Snackbar
    // -------------------------------------------------------------------------
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.surfaceDark,
      contentTextStyle: AppLightTheme.theme.snackBarTheme.contentTextStyle
          ?.copyWith(color: AppColors.white),
      actionTextColor: AppColors.primaryBlueLight,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.borderDark, width: 0.5),
      ),
    ),

    // -------------------------------------------------------------------------
    // List tile
    // -------------------------------------------------------------------------
    listTileTheme: ListTileThemeData(
      iconColor: AppColors.textSecondaryDark,
      textColor: AppColors.textPrimaryDark,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      tileColor: AppColors.surfaceDark,
    ),

    // -------------------------------------------------------------------------
    // Switch
    // -------------------------------------------------------------------------
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.white;
        }
        return AppColors.textSecondaryDark;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primaryBlue;
        }
        return AppColors.borderDark;
      }),
      trackOutlineColor: WidgetStatePropertyAll(Colors.transparent),
    ),

    // -------------------------------------------------------------------------
    // Checkbox
    // -------------------------------------------------------------------------
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primaryBlue;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStatePropertyAll(AppColors.white),
      side: const BorderSide(color: AppColors.borderDark, width: 1.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),

    // -------------------------------------------------------------------------
    // Progress indicators
    // -------------------------------------------------------------------------
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primaryBlue,
      circularTrackColor: Color(0xFF0D47A1),
      linearTrackColor: Color(0xFF0D47A1),
    ),
  );
}
