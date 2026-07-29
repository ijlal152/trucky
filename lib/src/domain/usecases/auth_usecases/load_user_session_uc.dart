import 'package:injectable/injectable.dart';
import 'package:trucky/core/usecase/usecase.dart';

import '../../entities/user_entity.dart';
import '../../repositories/auth_rep.dart';

@lazySingleton
class LoadUserSessionUseCase extends UseCase<void, UserEntity?> {
  final AuthRepo _repository;

  LoadUserSessionUseCase(this._repository);

  @override
  Future<UserEntity?> call(void _) {
    return _repository.loadUserSession();
  }
}
