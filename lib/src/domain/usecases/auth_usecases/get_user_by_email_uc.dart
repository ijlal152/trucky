import 'package:injectable/injectable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../entities/user_entity.dart';
import '../../repositories/auth_rep.dart';

@lazySingleton
class GetUserByEmailUseCase extends UseCase<String, UserEntity?>{
  final AuthRepo _repository;

  GetUserByEmailUseCase(this._repository);

  @override
  Future<UserEntity?> call(String email) {
    return _repository.getUserByEmail(email: email);
  }
}
