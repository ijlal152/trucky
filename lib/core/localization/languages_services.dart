import 'package:flutter/material.dart';

import 'app_localizations.dart';

extension LocalizationX on BuildContext {
  String tr(String key) =>
      AppLocalizationData.translate(key, Localizations.localeOf(this));
}
