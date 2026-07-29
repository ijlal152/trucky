import 'package:injectable/injectable.dart';
import 'package:trucky/core/usecase/usecase.dart';

import '../../entities/user_entity.dart';
import '../../repositories/auth_rep.dart';

@lazySingleton
class SaveUserSessionUseCase extends UseCase <UserEntity, void> {
  final AuthRepo _repository;

  SaveUserSessionUseCase(this._repository);

  @override
  Future<void> call(UserEntity user) {
    return _repository.saveUserSession(user: user);
  }
}
