import 'package:injectable/injectable.dart';
import 'package:trucky/core/usecase/usecase.dart';

import '../../repositories/auth_rep.dart';

@lazySingleton
class LogoutUseCase extends UseCase <void, void> {
  final AuthRepo _repository;

  LogoutUseCase(this._repository);

  @override
  Future<void> call(void _) {
    return _repository.clearUserSession();
  }
}
