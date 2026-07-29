import 'package:injectable/injectable.dart';

import '../../entities/user_entity.dart';
import '../../repositories/auth_rep.dart';
import 'sign_in_uc.dart';

@lazySingleton
class SignUpUseCase {
  final AuthRepo _repository;

  SignUpUseCase(this._repository);

  Future<String> call({
    required UserEntity user,
    required String password,
  }) async {
    if (user.email == null || user.email!.trim().isEmpty) {
      throw const ValidationAuthException('Email cannot be empty');
    }
    if (password.trim().isEmpty) {
      throw const ValidationAuthException('Password cannot be empty');
    }
    if (user.fullName == null || user.fullName!.trim().isEmpty) {
      throw const ValidationAuthException('Full name cannot be empty');
    }
    if (user.phoneNumber == null || user.phoneNumber!.trim().isEmpty) {
      throw const ValidationAuthException('Phone number cannot be empty');
    }
    if (user.businessName == null || user.businessName!.trim().isEmpty) {
      throw const ValidationAuthException('Business name cannot be empty');
    }

    return _repository.signUp(user: user, password: password);
  }
}
