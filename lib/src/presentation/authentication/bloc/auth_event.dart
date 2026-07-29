part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  const SignInRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class SignUpStepOneRequested extends AuthEvent {
  final String email;
  final String password;

  const SignUpStepOneRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class SignUpStepTwoRequested extends AuthEvent {
  final String fullName;
  final String phoneNumber;
  final String dialCode;
  final String businessName;
  final String address;

  const SignUpStepTwoRequested({
    required this.fullName,
    required this.phoneNumber,
    required this.dialCode,
    required this.businessName,
    required this.address,
  });

  @override
  List<Object?> get props => [
    fullName,
    phoneNumber,
    dialCode,
    businessName,
    address,
  ];
}

class ValidateEmailRequested extends AuthEvent {
  final String email;

  const ValidateEmailRequested({required this.email});

  @override
  List<Object?> get props => [email];
}

class ValidatePasswordRequested extends AuthEvent {
  final String password;
  final String? confirmPassword;

  const ValidatePasswordRequested({
    required this.password,
    this.confirmPassword,
  });

  @override
  List<Object?> get props => [password, confirmPassword];
}

class TogglePasswordVisibilityRequested extends AuthEvent {
  final bool isNewPassword;
  final bool isConfirmPassword;

  const TogglePasswordVisibilityRequested({
    this.isNewPassword = false,
    this.isConfirmPassword = false,
  });

  @override
  List<Object?> get props => [isNewPassword, isConfirmPassword];
}

class SelectCountryCodeRequested extends AuthEvent {
  final int index;

  const SelectCountryCodeRequested({required this.index});

  @override
  List<Object?> get props => [index];
}

class SearchCountryCodeRequested extends AuthEvent {
  final String query;

  const SearchCountryCodeRequested({required this.query});

  @override
  List<Object?> get props => [query];
}

class ResetAuthStateRequested extends AuthEvent {
  const ResetAuthStateRequested();
}

class LoadCountryCodesRequested extends AuthEvent {
  const LoadCountryCodesRequested();
}

class SignOutRequested extends AuthEvent {
  const SignOutRequested();
}

/// Fired on app start to check for a persisted session.
class RestoreSessionRequested extends AuthEvent {
  const RestoreSessionRequested();
}

/// Fired when the user picks a profile image during sign up.
class UpdateProfilePictureRequested extends AuthEvent {
  final String? path;
  const UpdateProfilePictureRequested(this.path);
  @override
  List<Object?> get props => [path];
}
