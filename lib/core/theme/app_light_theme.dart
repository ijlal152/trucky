import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

/// Light theme configuration matching the Trucky design.
class AppLightTheme {
  AppLightTheme._();

  static ThemeData get theme => _build(
    brightness: Brightness.light,
    colorScheme: AppColors.lightColorScheme,
    scaffoldBackground: AppColors.backgroundLight,
    cardColor: AppColors.surfaceLight,
    textPrimary: AppColors.textPrimaryLight,
    textSecondary: AppColors.textSecondaryLight,
    hint: AppColors.hintLight,
    border: AppColors.borderLight,
    divider: AppColors.dividerLight,
  );

  static ThemeData _build({
    required Brightness brightness,
    required ColorScheme colorScheme,
    required Color scaffoldBackground,
    required Color cardColor,
    required Color textPrimary,
    required Color textSecondary,
    required Color hint,
    required Color border,
    required Color divider,
  }) {
    final isDark = brightness == Brightness.dark;

    final textTheme = TextTheme(
      displayLarge: AppTextStyles.displayLarge.copyWith(color: textPrimary),
      displayMedium: AppTextStyles.displayMedium.copyWith(color: textPrimary),
      displaySmall: AppTextStyles.displaySmall.copyWith(color: textPrimary),
      headlineLarge: AppTextStyles.headlineLarge.copyWith(color: textPrimary),
      headlineMedium: AppTextStyles.headlineMedium.copyWith(color: textPrimary),
      headlineSmall: AppTextStyles.headlineSmall.copyWith(color: textPrimary),
      titleLarge: AppTextStyles.titleLarge.copyWith(color: textPrimary),
      titleMedium: AppTextStyles.titleMedium.copyWith(color: textPrimary),
      titleSmall: AppTextStyles.titleSmall.copyWith(color: textPrimary),
      bodyLarge: AppTextStyles.bodyLarge.copyWith(color: textPrimary),
      bodyMedium: AppTextStyles.bodyMedium.copyWith(color: textPrimary),
      bodySmall: AppTextStyles.bodySmall.copyWith(color: textSecondary),
      labelLarge: AppTextStyles.labelLarge.copyWith(color: textPrimary),
      labelMedium: AppTextStyles.labelMedium.copyWith(color: textPrimary),
      labelSmall: AppTextStyles.labelSmall.copyWith(color: textSecondary),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: scaffoldBackground,
      canvasColor: scaffoldBackground,
      cardColor: cardColor,
      dividerColor: divider,
      splashColor: AppColors.primaryBlue.withValues(alpha: 0.08),
      highlightColor: AppColors.primaryBlue.withValues(alpha: 0.04),
      hoverColor: AppColors.primaryBlue.withValues(alpha: 0.04),
      fontFamily: 'Inter-Regular',

      // -------------------------------------------------------------------------
      // Text theme
      // -------------------------------------------------------------------------
      textTheme: textTheme,
      primaryTextTheme: textTheme,

      // -------------------------------------------------------------------------
      // App bar
      // -------------------------------------------------------------------------
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: AppTextStyles.appBarTitle,
        iconTheme: const IconThemeData(color: AppColors.white),
        actionsIconTheme: const IconThemeData(color: AppColors.white),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: isDark ? Brightness.light : Brightness.light,
          statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
        ),
      ),

      // -------------------------------------------------------------------------
      // Cards
      // -------------------------------------------------------------------------
      cardTheme: CardThemeData(
        color: cardColor,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: border, width: 0.5),
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          textStyle: AppTextStyles.buttonPrimary,
        ),
      ),

      // -------------------------------------------------------------------------
      // Text buttons
      // -------------------------------------------------------------------------
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryBlue,
          textStyle: AppTextStyles.labelMedium,
        ),
      ),

      // -------------------------------------------------------------------------
      // Outlined buttons
      // -------------------------------------------------------------------------
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryBlue,
          side: const BorderSide(color: AppColors.primaryBlue, width: 1.5),
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          textStyle: AppTextStyles.labelMedium,
        ),
      ),

      // -------------------------------------------------------------------------
      // Floating action button
      // -------------------------------------------------------------------------
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.white,
        elevation: 4,
        highlightElevation: 6,
        shape: CircleBorder(),
      ),

      // -------------------------------------------------------------------------
      // Input fields
      // -------------------------------------------------------------------------
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cardColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        hintStyle: AppTextStyles.inputHint.copyWith(color: hint),
        labelStyle: AppTextStyles.bodyMedium.copyWith(color: textSecondary),
        floatingLabelStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.primaryBlue,
        ),
        helperStyle: AppTextStyles.bodySmall.copyWith(color: textSecondary),
        errorStyle: AppTextStyles.bodySmall.copyWith(color: AppColors.error),
        prefixIconColor: textSecondary,
        suffixIconColor: textSecondary,
        iconColor: textSecondary,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: border, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: border, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.primaryBlue,
            width: 1.5,
          ),
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
          borderSide: BorderSide(color: border, width: 1),
        ),
      ),

      // -------------------------------------------------------------------------
      // Bottom navigation bar
      // -------------------------------------------------------------------------
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: cardColor,
        selectedItemColor: AppColors.primaryBlue,
        unselectedItemColor: textSecondary,
        selectedLabelStyle: AppTextStyles.labelSmall,
        unselectedLabelStyle: AppTextStyles.labelSmall,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // -------------------------------------------------------------------------
      // Navigation bar (M3)
      // -------------------------------------------------------------------------
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: cardColor,
        indicatorColor: AppColors.primaryBlueLight,
        labelTextStyle: WidgetStatePropertyAll(AppTextStyles.labelSmall),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.primaryBlue);
          }
          return IconThemeData(color: textSecondary);
        }),
        elevation: 2,
        height: 70,
      ),

      // -------------------------------------------------------------------------
      // Dividers
      // -------------------------------------------------------------------------
      dividerTheme: DividerThemeData(
        color: divider,
        thickness: 0.5,
        space: 0.5,
      ),

      // -------------------------------------------------------------------------
      // Icons
      // -------------------------------------------------------------------------
      iconTheme: IconThemeData(color: textPrimary, size: 24),
      primaryIconTheme: const IconThemeData(color: AppColors.white, size: 24),

      // -------------------------------------------------------------------------
      // Progress indicators
      // -------------------------------------------------------------------------
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primaryBlue,
        circularTrackColor: Color(0xFFE3F2FD),
        linearTrackColor: Color(0xFFE3F2FD),
      ),

      // -------------------------------------------------------------------------
      // Snackbar
      // -------------------------------------------------------------------------
      snackBarTheme: SnackBarThemeData(
        backgroundColor: textPrimary,
        contentTextStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.white,
        ),
        actionTextColor: AppColors.primaryBlueLight,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),

      // -------------------------------------------------------------------------
      // Bottom sheet
      // -------------------------------------------------------------------------
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: cardColor,
        modalBackgroundColor: cardColor,
        elevation: 8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),

      // -------------------------------------------------------------------------
      // Dialog
      // -------------------------------------------------------------------------
      dialogTheme: DialogThemeData(
        backgroundColor: cardColor,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        titleTextStyle: AppTextStyles.titleLarge.copyWith(color: textPrimary),
        contentTextStyle: AppTextStyles.bodyMedium.copyWith(color: textPrimary),
      ),

      // -------------------------------------------------------------------------
      // Switch
      // -------------------------------------------------------------------------
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.white;
          }
          return AppColors.white.withValues(alpha: 0.8);
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryBlue;
          }
          return border;
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
        side: BorderSide(color: border, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),

      // -------------------------------------------------------------------------
      // List tile
      // -------------------------------------------------------------------------
      listTileTheme: ListTileThemeData(
        iconColor: textSecondary,
        textColor: textPrimary,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        tileColor: cardColor,
      ),
    );
  }
}
