import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../data/repo_impl/auth_repo_impl.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/auth_usecases/check_user_exists_uc.dart';
import '../../../domain/usecases/auth_usecases/load_user_session_uc.dart';
import '../../../domain/usecases/auth_usecases/logout_uc.dart';
import '../../../domain/usecases/auth_usecases/save_user_session_uc.dart';
import '../../../domain/usecases/auth_usecases/sign_in_uc.dart';
import '../../../domain/usecases/auth_usecases/sign_up_uc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;
  final LogoutUseCase _logoutUseCase;
  final CheckUserExistsUseCase _checkUserExistsUseCase;
  final SaveUserSessionUseCase _saveUserSessionUseCase;
  final LoadUserSessionUseCase _loadUserSessionUseCase;

  AuthBloc(
    this._signInUseCase,
    this._signUpUseCase,
    this._logoutUseCase,
    this._checkUserExistsUseCase,
    this._saveUserSessionUseCase,
    this._loadUserSessionUseCase,
  ) : super(const AuthState()) {
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
    on<RestoreSessionRequested>(_onRestoreSessionRequested);
    on<UpdateProfilePictureRequested>(_onUpdateProfilePictureRequested);

    add(const LoadCountryCodesRequested());
    add(const RestoreSessionRequested());
  }

  // ── Country codes (asset) ────────────────────────────────────────────

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
    } catch (_) {
      // Silently ignore — UI will show no list
    }
  }

  // ── Restore session (on app start) ──────────────────────────────────

  Future<void> _onRestoreSessionRequested(
    RestoreSessionRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final user = await _loadUserSessionUseCase(null);
      if (user != null) {
        emit(
          state.copyWith(status: AuthStatus.authenticated, currentUser: user),
        );
      }
    } catch (_) {
      // No session, stay unauthenticated
    }
  }

  // ── Sign in ─────────────────────────────────────────────────────────

  Future<void> _onSignInRequested(
    SignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        status: AuthStatus.loading,
        isLoading: true,
        errorMessage: null,
      ),
    );
    try {
      final user = await _signInUseCase(
        SignInParams(email: event.email, password: event.password),
      );
      await _saveUserSessionUseCase(user);
      emit(
        state.copyWith(
          status: AuthStatus.authenticated,
          isLoading: false,
          currentUser: user,
          email: user.email,
          successMessage: 'Signed in successfully',
          errorMessage: null,
        ),
      );
    } on UserNotFoundException catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.error,
          isLoading: false,
          errorMessage: e.message,
        ),
      );
    } on InvalidCredentialsException catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.error,
          isLoading: false,
          errorMessage: e.message,
        ),
      );
    } on ValidationAuthException catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.error,
          isLoading: false,
          errorMessage: e.message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.error,
          isLoading: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  // ── Sign up step 1 (email + password) ───────────────────────────────

  Future<void> _onSignUpStepOneRequested(
    SignUpStepOneRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final email = event.email.trim();
    final password = event.password;

    if (email.isEmpty) {
      emit(
        state.copyWith(
          isLoading: false,
          isEmailRequired: true,
          isPasswordRequired: false,
          errorMessage: 'Email is required',
        ),
      );
      return;
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      emit(
        state.copyWith(
          isLoading: false,
          isValidEmail: false,
          isEmailRequired: true,
          errorMessage: 'Invalid email format',
        ),
      );
      return;
    }
    if (password.isEmpty) {
      emit(
        state.copyWith(
          isLoading: false,
          isPasswordRequired: true,
          isEmailRequired: false,
          errorMessage: 'Password is required',
        ),
      );
      return;
    }

    // Password strength
    final hasLength = password.length >= 8;
    final hasUppercase = password.contains(RegExp(r'[A-Z]'));
    final hasNumber = password.contains(RegExp(r'[0-9]'));
    final hasSymbol = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    final isValidPassword = hasLength && (hasUppercase || hasSymbol) && hasNumber;

    emit(
      state.copyWith(
        isLoading: false,
        isValidPasswordLength: hasLength,
        hasUppercaseSymbol: hasUppercase || hasSymbol,
        hasANumber: hasNumber,
        isValidPassword: isValidPassword,
        email: email,
        password: password,
      ),
    );

    if (!isValidPassword) {
      emit(state.copyWith(errorMessage: 'Password does not meet requirements'));
      return;
    }

    // Check if email already registered
    try {
      final exists = await _checkUserExistsUseCase(email);
      if (exists) {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: 'Email already exists',
          ),
        );
        return;
      }
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Could not verify email: ${e.toString()}',
        ),
      );
      return;
    }

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

  // ── Sign up step 2 (full account) ──────────────────────────────────

  Future<void> _onSignUpStepTwoRequested(
    SignUpStepTwoRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    if (event.fullName.trim().isEmpty) {
      emit(
        state.copyWith(
          isLoading: false,
          isNameRequired: true,
          isPhoneRequired: false,
          isBusinessRequired: false,
          errorMessage: 'Full name is required',
        ),
      );
      return;
    }
    if (event.phoneNumber.trim().isEmpty) {
      emit(
        state.copyWith(
          isLoading: false,
          isNameRequired: false,
          isPhoneRequired: true,
          isBusinessRequired: false,
          errorMessage: 'Phone number is required',
        ),
      );
      return;
    }
    if (event.businessName.trim().isEmpty) {
      emit(
        state.copyWith(
          isLoading: false,
          isNameRequired: false,
          isPhoneRequired: false,
          isBusinessRequired: true,
          errorMessage: 'Business name is required',
        ),
      );
      return;
    }

    final newUser = UserEntity(
      email: state.email,
      fullName: event.fullName.trim(),
      countryCode: event.dialCode,
      currency: state.currency,
      phoneNumber: event.phoneNumber.trim(),
      businessName: event.businessName.trim(),
      address: event.address.trim(),
      profilePicture: state.profilePicture,
      isActive: true,
      role: 'user',
    );

    try {
      await _signUpUseCase(user: newUser, password: state.password ?? '');

      // Sign the new user in immediately and persist the session.
      final signedIn = await _signInUseCase(
        SignInParams(
          email: newUser.email ?? '',
          password: state.password ?? '',
        ),
      );
      await _saveUserSessionUseCase(signedIn);

      emit(
        state.copyWith(
          status: AuthStatus.authenticated,
          isLoading: false,
          currentUser: signedIn,
          successMessage: 'Account created successfully',
          isNameRequired: false,
          isPhoneRequired: false,
          isBusinessRequired: false,
        ),
      );
    } on UserAlreadyExistsException catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.message));
    } on ValidationAuthException catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.message));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  // ── Validation ─────────────────────────────────────────────────────

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

  // ── UI helpers ─────────────────────────────────────────────────────

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
      emit(
        state.copyWith(
          dialCode: selected.dialCode ?? '+213',
          currency: selected.currencyCode ?? state.currency,
        ),
      );
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

  void _onUpdateProfilePictureRequested(
    UpdateProfilePictureRequested event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(profilePicture: event.path));
  }

  void _onResetAuthStateRequested(
    ResetAuthStateRequested event,
    Emitter<AuthState> emit,
  ) {
    emit(const AuthState(countryCodes: [], filteredCountryCodes: []));
    add(const LoadCountryCodesRequested());
  }

  // ── Sign out ───────────────────────────────────────────────────────

  Future<void> _onSignOutRequested(
    SignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading, isLoading: true));
    try {
      await _logoutUseCase(null);
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
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
