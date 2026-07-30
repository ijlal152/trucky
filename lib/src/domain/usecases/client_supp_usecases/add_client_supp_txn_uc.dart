import 'package:injectable/injectable.dart';

import '../../../../core/usecase/usecase.dart';

/// Stub — transaction creation will be implemented separately.
@lazySingleton
class AddClientSuppTxnUseCase extends UseCase<NoParams, void> {
  AddClientSuppTxnUseCase();

  @override
  Future<void> call(NoParams params) async {
    // TODO: implement when transaction feature is built
  }
}
