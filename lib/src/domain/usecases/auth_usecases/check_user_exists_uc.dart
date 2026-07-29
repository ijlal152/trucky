import 'package:injectable/injectable.dart';
import 'package:trucky/core/usecase/usecase.dart';

import '../../repositories/auth_rep.dart';

@lazySingleton
class CheckUserExistsUseCase extends UseCase<String, bool> {
  final AuthRepo _repository;

  CheckUserExistsUseCase(this._repository);

  @override
  Future<bool> call(String email) {
    return _repository.checkUserExists(email: email);
  }
}
