import 'package:injectable/injectable.dart';

import '../../../../core/usecase/usecase.dart';

/// Stub — transaction list will be implemented separately.
@lazySingleton
class GetAllTxnUseCase extends UseCase<NoParams, void> {
  GetAllTxnUseCase();

  @override
  Future<void> call(NoParams params) async {
    // TODO: implement when transaction feature is built
  }
}
