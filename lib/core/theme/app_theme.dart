import 'package:flutter/material.dart';

import 'app_dark_theme.dart';
import 'app_light_theme.dart';

/// Aggregator for Trucky's light and dark themes.
class AppTheme {
  AppTheme._();

  static ThemeData get light => AppLightTheme.theme;
  static ThemeData get dark => AppDarkTheme.theme;
}
