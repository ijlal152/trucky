import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../entities/user_entity.dart';
import '../../repositories/auth_rep.dart';

@lazySingleton
class SignInUseCase extends UseCase<SignInParams, UserEntity>{
  final AuthRepo _repository;

  SignInUseCase(this._repository);

  @override
  Future<UserEntity> call(SignInParams params) async {
    final email = params.email;
    final password = params.password;
    if (email.trim().isEmpty) {
      throw const ValidationAuthException('Email cannot be empty');
    }
    if (password.trim().isEmpty) {
      throw const ValidationAuthException('Password cannot be empty');
    }
    return _repository.signIn(email: email, password: password);
  }
}

class SignInParams extends Equatable {
  final String email;
  final String password;

  const SignInParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

/// Local validation exception thrown by use cases.
class ValidationAuthException implements Exception {
  final String message;
  const ValidationAuthException(this.message);
  @override
  String toString() => message;
}
