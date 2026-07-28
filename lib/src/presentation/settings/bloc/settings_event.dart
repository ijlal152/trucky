part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

class LoadSettings extends SettingsEvent {
  const LoadSettings();
}

class UpdateThemeMode extends SettingsEvent {
  final bool isDarkMode;

  const UpdateThemeMode({required this.isDarkMode});

  @override
  List<Object?> get props => [isDarkMode];
}

class UpdateLanguage extends SettingsEvent {
  final String language;

  const UpdateLanguage({required this.language});

  @override
  List<Object?> get props => [language];
}
