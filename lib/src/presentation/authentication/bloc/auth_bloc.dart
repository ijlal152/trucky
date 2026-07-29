import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<SignInRequested>(_onSignInRequested);
    on<SignUpStepOneRequested>(_onSignUpStepOneRequested);
    on<SignUpStepTwoRequested>(_onSignUpStepTwoRequested);
    on<ValidateEmailRequested>(_onValidateEmailRequested);
    on<ValidatePasswordRequested>(_onValidatePasswordRequested);
    on<TogglePasswordVisibilityRequested>(_onTogglePasswordVisibilityRequested);
    on<SelectCountryCodeRequested>(_onSelectCountryCodeRequested);
    on<SearchCountryCodeRequested>(_onSearchCountryCodeRequested);
    on<ResetAuthStateRequested>(_onResetAuthStateRequested);
    on<SignOutRequested>(_onSignOutRequested);
    on<LoadCountryCodesRequested>(_onLoadCountryCodesRequested);
    add(const LoadCountryCodesRequested());
  }

  Future<void> _onLoadCountryCodesRequested(
    LoadCountryCodesRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final String jsonString = await rootBundle.loadString(
        'assets/country_codes_currency.json',
      );
      final List<dynamic> jsonList = json.decode(jsonString);
      final countryCodes = jsonList
          .map((e) => CountryCodeModel.fromJson(e))
          .toList();
      emit(
        state.copyWith(
          countryCodes: countryCodes,
          filteredCountryCodes: countryCodes,
        ),
      );
    } catch (e) {
      // Handle error silently or log
    }
  }

  Future<void> _onSignInRequested(
    SignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading, isLoading: true));
    try {
      await Future.delayed(const Duration(seconds: 1));
      emit(
        state.copyWith(
          status: AuthStatus.authenticated,
          isLoading: true,
          message: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.error,
          isLoading: false,
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _onSignUpStepOneRequested(
    SignUpStepOneRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    // Validate email
    if (event.email.trim().isEmpty) {
      emit(
        state.copyWith(
          isLoading: false,
          isEmailRequired: true,
          errorMessage: 'Email is required',
        ),
      );
      return;
    }

    // Validate email format
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(event.email.trim())) {
      emit(
        state.copyWith(
          isLoading: false,
          isValidEmail: false,
          errorMessage: 'Invalid email format',
        ),
      );
      return;
    }

    // Validate password
    if (event.password.trim().isEmpty) {
      emit(
        state.copyWith(
          isLoading: false,
          isPasswordRequired: true,
          errorMessage: 'Password is required',
        ),
      );
      return;
    }

    // Validate password strength
    final hasLength = event.password.length >= 8;
    final hasUppercase = event.password.contains(RegExp(r'[A-Z]'));
    final hasNumber = event.password.contains(RegExp(r'[0-9]'));
    final hasSymbol = event.password.contains(
      RegExp(r'[!@#$%^&*(),.?":{}|<>]'),
    );

    final isValidPassword = hasLength && hasUppercase && hasNumber && hasSymbol;

    emit(
      state.copyWith(
        isLoading: false,
        isValidPasswordLength: hasLength,
        hasUppercaseSymbol: hasUppercase || hasSymbol,
        hasANumber: hasNumber,
        isValidPassword: isValidPassword,
        email: event.email,
        password: event.password,
      ),
    );

    if (!isValidPassword) {
      emit(state.copyWith(errorMessage: 'Password does not meet requirements'));
      return;
    }

    // TODO: Check if user already exists via repository
    // For now, proceed to step two
    emit(
      state.copyWith(
        status: AuthStatus.stepOneVerified,
        isLoading: false,
        successMessage: 'Step one completed',
        isEmailRequired: false,
        isPasswordRequired: false,
      ),
    );
  }

  Future<void> _onSignUpStepTwoRequested(
    SignUpStepTwoRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    // Validate required fields
    if (event.fullName.trim().isEmpty) {
      emit(
        state.copyWith(
          isLoading: false,
          isNameRequired: true,
          errorMessage: 'Full name is required',
        ),
      );
      return;
    }

    if (event.phoneNumber.trim().isEmpty) {
      emit(
        state.copyWith(
          isLoading: false,
          isPhoneRequired: true,
          errorMessage: 'Phone number is required',
        ),
      );
      return;
    }

    if (event.businessName.trim().isEmpty) {
      emit(
        state.copyWith(
          isLoading: false,
          isBusinessRequired: true,
          errorMessage: 'Business name is required',
        ),
      );
      return;
    }

    // All validations passed
    emit(
      state.copyWith(
        isLoading: false,
        fullName: event.fullName,
        phoneNumber: event.phoneNumber,
        dialCode: event.dialCode,
        businessName: event.businessName,
        address: event.address,
        isNameRequired: false,
        isPhoneRequired: false,
        isBusinessRequired: false,
        successMessage: 'Registration completed',
      ),
    );

    // TODO: Call sign up use case with all data
    // Navigate to dashboard
    emit(state.copyWith(status: AuthStatus.authenticated));
  }

  void _onValidateEmailRequested(
    ValidateEmailRequested event,
    Emitter<AuthState> emit,
  ) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    final isValid = emailRegex.hasMatch(event.email.trim());
    emit(
      state.copyWith(
        isValidEmail: isValid,
        isEmailRequired: event.email.trim().isEmpty,
        email: event.email,
      ),
    );
  }

  void _onValidatePasswordRequested(
    ValidatePasswordRequested event,
    Emitter<AuthState> emit,
  ) {
    final password = event.password;
    final confirmPassword = event.confirmPassword;

    final hasLength = password.length >= 8;
    final hasUppercase = password.contains(RegExp(r'[A-Z]'));
    final hasNumber = password.contains(RegExp(r'[0-9]'));
    final hasSymbol = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    final isValidPassword = hasLength && hasUppercase && hasNumber && hasSymbol;
    final passwordsMatch =
        confirmPassword == null || password == confirmPassword;

    emit(
      state.copyWith(
        isValidPasswordLength: hasLength,
        hasUppercaseSymbol: hasUppercase || hasSymbol,
        hasANumber: hasNumber,
        isValidPassword: isValidPassword && passwordsMatch,
        password: password,
      ),
    );
  }

  void _onTogglePasswordVisibilityRequested(
    TogglePasswordVisibilityRequested event,
    Emitter<AuthState> emit,
  ) {
    if (event.isNewPassword) {
      emit(state.copyWith(newPasswordObscure: !state.newPasswordObscure));
    } else if (event.isConfirmPassword) {
      emit(
        state.copyWith(confirmPasswordObscure: !state.confirmPasswordObscure),
      );
    } else {
      emit(state.copyWith(passwordObscure: !state.passwordObscure));
    }
  }

  void _onSelectCountryCodeRequested(
    SelectCountryCodeRequested event,
    Emitter<AuthState> emit,
  ) {
    if (event.index >= 0 && event.index < state.filteredCountryCodes.length) {
      final selected = state.filteredCountryCodes[event.index];
      emit(state.copyWith(dialCode: selected.dialCode ?? '+213'));
    }
  }

  void _onSearchCountryCodeRequested(
    SearchCountryCodeRequested event,
    Emitter<AuthState> emit,
  ) {
    final query = event.query.toLowerCase();
    final filtered = state.countryCodes.where((country) {
      final countryName = country.country?.toLowerCase() ?? '';
      final dialCode = country.dialCode?.toLowerCase() ?? '';
      return countryName.contains(query) || dialCode.contains(query);
    }).toList();
    emit(state.copyWith(filteredCountryCodes: filtered));
  }

  void _onResetAuthStateRequested(
    ResetAuthStateRequested event,
    Emitter<AuthState> emit,
  ) {
    emit(const AuthState(countryCodes: [], filteredCountryCodes: []));
    add(const LoadCountryCodesRequested());
  }

  Future<void> _onSignOutRequested(
    SignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading, isLoading: true));
    try {
      // TODO: Implement actual sign out logic
      await Future.delayed(const Duration(milliseconds: 500));
      emit(
        const AuthState(
          status: AuthStatus.unauthenticated,
          countryCodes: [],
          filteredCountryCodes: [],
        ),
      );
      add(const LoadCountryCodesRequested());
    } catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.error,
          isLoading: false,
          message: e.toString(),
        ),
      );
    }
  }
}
