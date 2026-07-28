part of 'auth_bloc.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthState extends Equatable {
  final AuthStatus status;
  final String? message;

  const AuthState({this.status = AuthStatus.initial, this.message});

  AuthState copyWith({AuthStatus? status, String? message}) {
    return AuthState(status: status ?? this.status, message: message);
  }

  @override
  List<Object?> get props => [status, message];
}
