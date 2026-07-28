part of 'auth_bloc.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthState extends Equatable {
  final AuthStatus status;
  final String? message;
  final String? email;
  final String? password;
  final String? fullName;
  final String? phoneNumber;
  final String? dialCode;
  final String? businessName;
  final String? address;
  final bool isLoading;
  final bool isNameRequired;
  final bool isPhoneRequired;
  final bool isBusinessRequired;
  final bool isEmailRequired;
  final bool isPasswordRequired;
  final bool isValidEmail;
  final bool passwordObscure;
  final bool newPasswordObscure;
  final bool confirmPasswordObscure;
  final bool isValidPassword;
  final bool isValidPasswordLength;
  final bool hasUppercaseSymbol;
  final bool hasANumber;
  final List<CountryCodeModel> countryCodes;
  final List<CountryCodeModel> filteredCountryCodes;
  final String? errorMessage;
  final String? successMessage;

  const AuthState({
    this.status = AuthStatus.initial,
    this.message,
    this.email,
    this.password,
    this.fullName,
    this.phoneNumber,
    this.dialCode = '+213',
    this.businessName,
    this.address,
    this.isLoading = false,
    this.isNameRequired = false,
    this.isPhoneRequired = false,
    this.isBusinessRequired = false,
    this.isEmailRequired = false,
    this.isPasswordRequired = false,
    this.isValidEmail = true,
    this.passwordObscure = true,
    this.newPasswordObscure = true,
    this.confirmPasswordObscure = true,
    this.isValidPassword = false,
    this.isValidPasswordLength = false,
    this.hasUppercaseSymbol = false,
    this.hasANumber = false,
    this.countryCodes = const [],
    this.filteredCountryCodes = const [],
    this.errorMessage,
    this.successMessage,
  });

  AuthState copyWith({
    AuthStatus? status,
    String? message,
    String? email,
    String? password,
    String? fullName,
    String? phoneNumber,
    String? dialCode,
    String? businessName,
    String? address,
    bool? isLoading,
    bool? isNameRequired,
    bool? isPhoneRequired,
    bool? isBusinessRequired,
    bool? isEmailRequired,
    bool? isPasswordRequired,
    bool? isValidEmail,
    bool? passwordObscure,
    bool? newPasswordObscure,
    bool? confirmPasswordObscure,
    bool? isValidPassword,
    bool? isValidPasswordLength,
    bool? hasUppercaseSymbol,
    bool? hasANumber,
    List<CountryCodeModel>? countryCodes,
    List<CountryCodeModel>? filteredCountryCodes,
    String? errorMessage,
    String? successMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      message: message ?? this.message,
      email: email ?? this.email,
      password: password ?? this.password,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dialCode: dialCode ?? this.dialCode,
      businessName: businessName ?? this.businessName,
      address: address ?? this.address,
      isLoading: isLoading ?? this.isLoading,
      isNameRequired: isNameRequired ?? this.isNameRequired,
      isPhoneRequired: isPhoneRequired ?? this.isPhoneRequired,
      isBusinessRequired: isBusinessRequired ?? this.isBusinessRequired,
      isEmailRequired: isEmailRequired ?? this.isEmailRequired,
      isPasswordRequired: isPasswordRequired ?? this.isPasswordRequired,
      isValidEmail: isValidEmail ?? this.isValidEmail,
      passwordObscure: passwordObscure ?? this.passwordObscure,
      newPasswordObscure: newPasswordObscure ?? this.newPasswordObscure,
      confirmPasswordObscure:
          confirmPasswordObscure ?? this.confirmPasswordObscure,
      isValidPassword: isValidPassword ?? this.isValidPassword,
      isValidPasswordLength:
          isValidPasswordLength ?? this.isValidPasswordLength,
      hasUppercaseSymbol: hasUppercaseSymbol ?? this.hasUppercaseSymbol,
      hasANumber: hasANumber ?? this.hasANumber,
      countryCodes: countryCodes ?? this.countryCodes,
      filteredCountryCodes: filteredCountryCodes ?? this.filteredCountryCodes,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    message,
    email,
    password,
    fullName,
    phoneNumber,
    dialCode,
    businessName,
    address,
    isLoading,
    isNameRequired,
    isPhoneRequired,
    isBusinessRequired,
    isEmailRequired,
    isPasswordRequired,
    isValidEmail,
    passwordObscure,
    newPasswordObscure,
    confirmPasswordObscure,
    isValidPassword,
    isValidPasswordLength,
    hasUppercaseSymbol,
    hasANumber,
    countryCodes,
    filteredCountryCodes,
    errorMessage,
    successMessage,
  ];
}

class CountryCodeModel extends Equatable {
  final String? country;
  final String? dialCode;
  final String? currencyCode;
  final String? currencySymbol;

  const CountryCodeModel({
    this.country,
    this.dialCode,
    this.currencyCode,
    this.currencySymbol,
  });

  factory CountryCodeModel.fromJson(Map<String, dynamic> json) {
    return CountryCodeModel(
      country: json['country']?['en'] ?? json['country']?.toString(),
      dialCode: json['dial_code']?.toString(),
      currencyCode: json['currency']?['en']?.toString(),
      currencySymbol: json['currency']?['en']?.toString(),
    );
  }

  @override
  List<Object?> get props => [country, dialCode, currencyCode, currencySymbol];
}
