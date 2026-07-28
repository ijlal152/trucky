part of 'settings_bloc.dart';

enum SettingsStatus { initial, loading, loaded, error }

class SettingsState extends Equatable {
  final SettingsStatus status;
  final String? message;
  final bool isDarkMode;
  final String language;

  const SettingsState({
    this.status = SettingsStatus.initial,
    this.message,
    this.isDarkMode = false,
    this.language = 'en',
  });

  SettingsState copyWith({
    SettingsStatus? status,
    String? message,
    bool? isDarkMode,
    String? language,
  }) {
    return SettingsState(
      status: status ?? this.status,
      message: message,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      language: language ?? this.language,
    );
  }

  @override
  List<Object?> get props => [status, message, isDarkMode, language];
}
