import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../repositories/client_supp_repo.dart';

@lazySingleton
class DeleteClientSuppUseCase extends UseCase<DeleteClientSuppParams, void> {
  final ClientSuppRepo _repo;

  DeleteClientSuppUseCase(this._repo);

  @override
  Future<void> call(DeleteClientSuppParams params) async {
    return _repo.delete(id: params.id);
  }
}

class DeleteClientSuppParams extends Equatable {
  final String id;
  const DeleteClientSuppParams({required this.id});

  @override
  List<Object?> get props => [id];
}
